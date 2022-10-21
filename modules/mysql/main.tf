# Official Google module for MySQL: https://github.com/terraform-google-modules/terraform-google-sql-db/tree/master/modules/mysql
# TODO: Datasource to fail fast if backup region is not specified
data "google_compute_zones" "this" {
  project = var.project_id
  region  = var.region
}

# Select a zone randomly
resource "random_shuffle" "zone" {
  input        = data.google_compute_zones.this.names
  result_count = 1
}

locals {
  zone = random_shuffle.zone.result[0]
  ip_configuration = {
    ipv4_enabled = var.public
    # We never set authorized networks, we need all connections via the
    # public IP to be mediated by Cloud SQL Proxy.
    authorized_networks = []
    require_ssl         = var.require_ssl
    private_network     = var.private_network
    allocated_ip_range  = var.allocated_ip_range
  }

  replicas = [
    for x, settings in var.replicas : {
      name                  = x
      tier                  = lookup(settings, "tier", var.tier)
      zone                  = lookup(settings, "zone", local.zone)
      disk_type             = lookup(settings, "disk_type", var.disk_type)
      disk_autoresize       = true
      disk_autoresize_limit = var.disk_limit
      disk_size             = "10"
      user_labels           = var.labels
      database_flags        = var.database_flags
      ip_configuration      = local.ip_configuration
      encryption_key_name   = var.encryption_key_name
    }
  ]
  default_backup_configuration = {
    enabled                        = false
    point_in_time_recovery_enabled = false
    binary_log_enabled             = lookup(var.backup_configuration, "point_in_time_recovery_enabled", false) # Must be true is point_in_time_recovery_enabled is true
    start_time                     = "03:00"                                                                   # Time when backcup configuration is starting
    transaction_log_retention_days = "7"                                                                       # The number of days of transaction logs we retain for point in time restore, from 1-7.
    retained_backups               = 7
    retention_unit                 = "COUNT"
  }
  backup_configuration = merge(local.default_backup_configuration, var.backup_configuration)

  additional_databases = [for n in var.databases : {
    name      = n
    collation = var.db_collation
    charset   = var.db_charset
  }]
}

# Passwords
module "secrets" {
  source = "../secrets"

  project_id     = var.project_id
  instance_name  = var.name
  users          = var.users
  region         = var.region
  create_secrets = var.create_secrets
}

# Instance
module "mysql-db" {
  source  = "GoogleCloudPlatform/sql-db/google//modules/mysql"
  version = "11.0.0"

  name                 = var.name # Mandatory
  random_instance_name = true
  database_version     = var.engine_version # Mandatory
  project_id           = var.project_id     # Mandatory
  zone                 = local.zone
  region               = var.region
  tier                 = var.tier
  user_labels          = var.labels

  db_charset   = var.db_charset
  db_collation = var.db_collation

  # Storage
  disk_autoresize = true
  disk_size       = 10
  disk_type       = var.disk_type

  # Configuration
  database_flags = var.database_flags

  # High Availability
  availability_type = var.availability_type

  # Backup
  backup_configuration = local.backup_configuration

  # Replicas
  read_replicas = local.replicas

  # Users
  enable_default_user = false
  additional_users    = module.secrets.users_passwords

  # Databases
  enable_default_db    = false
  additional_databases = length(var.databases) == 0 ? [] : local.additional_databases

  # Instance
  deletion_protection = var.instance_deletion_protection

  # Encryption
  encryption_key_name = var.encryption_key_name

  # Network
  ip_configuration = local.ip_configuration

  # Terraform timeout
  create_timeout = "20m"
}

resource "google_storage_bucket_iam_member" "exporter" {
  for_each = var.sql_exporter.bucket_name != "" ? toset(["1"]) : toset([])
  bucket   = var.sql_exporter.bucket_name
  role     = "roles/storage.admin"
  member   = "serviceAccount:${module.postgresql-db.instance_service_account_email_address}"
}

resource "google_cloud_scheduler_job" "exporter" {
  for_each    = var.sql_exporter.bucket_name != "" ? toset(var.additional_databases) : toset([])
  name        = "${each.key}-exporter"
  project     = var.project_id
  region      = local.region
  description = "exporter"
  schedule    = var.sql_exporter.schedule
  time_zone   = var.sql_exporter.timezone

  pubsub_target {
    topic_name = var.sql_exporter.pubsub_topic
    data       = base64encode("{\"Db\": \"${each.key}\", \"Instance\": \"${module.postgresql-db.instance_name}\", \"Project\": \"${var.project_id}\", \"Gs\": \"gs://${var.sql_exporter.bucket_name}\"}")
  }
}

