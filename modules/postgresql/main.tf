# Official Google module for PostgreSQL: https://github.com/terraform-google-modules/terraform-google-sql-db/tree/master/modules/postgresql
# TODO: Datasource to fail fast if backup region is not specified
data "google_compute_zones" "this" {
  region = local.is_region ? var.location : local.region
}

locals {
  is_region         = length(local.splitted_location) == 2
  splitted_location = split("-", var.location)
  region            = local.is_region ? var.location : join("",slice(local.splitted_location, 0, 1))
  zone              = local.is_region ? data.google_compute_zones.this.names[0] : var.location
  ip_configuration = {
    ipv4_enabled = !var.private
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
      disk_type             = lookup(settings, "disk_type", "PD_SSD")
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
    point_in_time_recovery_enabled = false
    enabled                        = false
    start_time                     = "03:00" # Time when backcup configuration is starting
    transaction_log_retention_days = "7"     # The number of days of transaction logs we retain for point in time restore, from 1-7.
    retained_backups               = 7
    retention_unit                 = "COUNT"
  }
  backup_configuration = merge(local.default_backup_configuration, var.backup_configuration)
}

# Passwords
module "secrets" {
  source = "../secrets"

  project_id     = var.project_id
  instance_name  = var.name
  users          = var.additional_users
  region         = local.region
  create_secrets = var.create_secrets
}

# Instance
module "postgresql-db" {
  source  = "GoogleCloudPlatform/sql-db/google//modules/postgresql"
  version = "11.0.0"

  name             = var.name           # Mandatory
  database_version = var.engine_version # Mandatory
  project_id       = var.project_id     # Mandatory
  zone             = local.zone
  region           = local.region
  tier             = var.tier
  user_labels      = var.labels

  db_charset   = var.db_charset
  db_collation = var.db_collation

  # Storage
  disk_autoresize = true
  disk_size       = 10
  disk_type       = "PD_SSD"

  # Configuration
  database_flags = var.database_flags

  # High Availability
  availability_type = local.is_region ? "REGIONAL" : "ZONAL"

  # Backup
  backup_configuration = local.backup_configuration

  # Replicas
  read_replicas = local.replicas

  # Users
  enable_default_user = false
  additional_users    = module.secrets.users_passwords

  # Databases
  enable_default_db    = false
  additional_databases = length(var.additional_databases) == 0 ? [] : var.additional_databases

  # Instance
  deletion_protection = var.instance_deletion_protection

  # Encryption
  encryption_key_name = var.encryption_key_name

  # Network
  ip_configuration = local.ip_configuration
}
