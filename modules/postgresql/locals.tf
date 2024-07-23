locals {
  zone = random_shuffle.zone.result[0]
  ip_configuration = {
    ipv4_enabled = var.public
    # We never set authorized networks, we need all connections via the
    # public IP to be mediated by Cloud SQL Proxy.
    authorized_networks = []
    require_ssl         = var.ssl_mode == "TRUSTED_CLIENT_CERTIFICATE_REQUIRED" ? true : false # See docs for possible values: https://cloud.google.com/sql/docs/postgres/admin-api/rest/v1beta4/instances#ipconfiguration
    ssl_mode            = var.ssl_mode
    private_network     = var.private_network
    allocated_ip_range  = var.allocated_ip_range
  }

  replicas = [
    for x, settings in var.replicas : {
      name                  = x
      tier                  = lookup(settings, "tier", var.tier)
      zone                  = lookup(settings, "zone", local.zone)
      disk_type             = lookup(settings, "disk_type", var.disk_type)
      availability_type     = lookup(settings, "availability_type", var.availability_type)
      disk_size             = lookup(settings, "disk_size", var.replica_disk_size)
      disk_autoresize       = true
      disk_autoresize_limit = var.disk_limit
      user_labels           = var.labels
      database_flags        = var.database_flags
      ip_configuration      = local.ip_configuration
      encryption_key_name   = module.encryption.key_id
    }
  ]
  default_backup_configuration = {
    enabled                        = false
    point_in_time_recovery_enabled = false
    start_time                     = "03:00" # Time when backcup configuration is starting
    transaction_log_retention_days = "7"     # The number of days of transaction logs we retain for point in time restore, from 1-7.
    retained_backups               = 7
    retention_unit                 = "COUNT"
  }
  backup_configuration = merge(local.default_backup_configuration, var.backup_configuration)

  additional_databases = [for key, value in var.databases : {
    name      = key
    collation = var.db_collation
    charset   = var.db_charset
  }]
}
