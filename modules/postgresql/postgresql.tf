# Select a zone randomly
resource "random_shuffle" "zone" {
  input        = data.google_compute_zones.this.names
  result_count = 1
}

# Instance
module "postgresql-db" {
  source  = "GoogleCloudPlatform/sql-db/google//modules/postgresql"
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
  encryption_key_name = module.encryption.key_id

  # Network
  ip_configuration = local.ip_configuration

  # Terraform timeout
  create_timeout = "20m"
}

