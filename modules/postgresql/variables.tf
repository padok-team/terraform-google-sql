variable "name" {
  description = "The name of the Cloud SQL resource."
  type        = string
}

variable "project_id" {
  description = "The project ID to manage the Cloud SQL resource."
  type        = string
}

variable "zone" {
  description = "The zone for the master instance, it should be something like: us-central1-a, us-east1-c, etc."
  type        = string
}

variable "region" {
  description = "The region for the master instance, it should be something like: us-central1-a, us-east1-c, etc."
  type        = string
}

variable "engine_version" {
  description = "The version of PostgreSQL engine."
  type        = string
  default     = "POSTGRES_11"
}

variable "nb_cpu" {
  description = "Number of virtual processors."
  type        = number

  validation {
    condition     = var.nb_cpu == 1 || (var.nb_cpu >= 2 && var.nb_cpu <= 96 && var.nb_cpu % 2 == 0) # https://cloud.google.com/sql/docs/postgres/create-instance#machine-types
    error_message = "Error: invalid number of CPU. Set an even number of processors between 2 and 96 (or 1)."
  }
}

variable "ram" {
  description = "Quantity of RAM (in Mb)."
  type        = number
}

variable "disk_size" {
  description = "Size of the db disk (in Gb)."
  type        = number
}

variable "disk_autoresize_limit" {
  description = "The maximum size to which storage can be auto increased."
  type        = number
}

variable "high_availability" {
  description = "Activate or not high availability for your DB."
  type        = bool
  default     = true
}

variable "backup_configuration" {
  description = "The backup_configuration settings subblock for the database setings."
  default = {
    point_in_time_recovery_enabled = false
    enabled                        = false
    start_time                     = "03:00" # Time when backcup configuration is starting
    transaction_log_retention_days = "7"     # The number of days of transaction logs we retain for point in time restore, from 1-7.
    retained_backups               = 7
    retention_unit                 = "COUNT"
  }
}

variable "nb_replicas" {
  description = "Number of read replicas you need."
  type        = number
  default     = 0
}

variable "db_collation" {
  description = "Collation for the DB."
  type        = string
  default     = "en_US.UTF8" # PostgreSQL Collation support: https://www.postgresql.org/docs/9.6/collation.html
}

variable "db_charset" {
  description = "Charset for the DB."
  type        = string
  default     = "utf8" # PostgreSQL Charset support: https://www.postgresql.org/docs/9.6/multibyte.html
}

variable "ha_external_ip_range" {
  description = "The ip range to allow connecting from/to Cloud SQL."
  type        = string
  default     = "192.10.10.10/32"
}

variable "instance_deletion_protection" {
  description = "Used to block Terraform from deleting a SQL Instance."
  type        = bool
  default     = false
}

variable "additional_databases" {
  description = "List of the default DBs you want to create."
  type = list(object({
    name      = string
    charset   = string
    collation = string
  }))
}

variable "additional_users" {
  description = "List of the User's name you want to create (passwords will be auto-generated). Warning! All those users will be admin and have access to all databases created with this module."
  type        = list(string)
}

variable "vpc_network" {
  description = "Name of the VPC within the instance SQL is deployed."
  type        = string
}


variable "assign_public_ip" {
  description = "Set to true if the master instance should also have a public IP (less secure)."
  type        = bool
  default     = false
}

variable "require_ssl" {
  description = "Set to false if you don not want to enforece SSL  (less secure)."
  type        = bool
  default     = true
}

variable "private_network" {
  description = "Define the CIDR of your private network."
  type        = string
}

variable "allocated_ip_range" {
  description = "The name of the allocated ip range for the private ip CloudSQL instance. For example: \"google-managed-services-default\". If set, the instance ip will be created in the allocated range."
  type        = string
}

variable "create_secrets" {
  description = "Do we create the secrets in secret manager?"
  type        = bool
  default     = true
}
