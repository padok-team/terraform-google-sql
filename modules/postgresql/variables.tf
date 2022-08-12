variable "name" {
  description = "The name of the Cloud SQL resource."
  type        = string
}

variable "project_id" {
  description = "The project ID to manage the Cloud SQL resource."
  type        = string
}

variable "location" {
  description = "Region or Zone for the master instance, this will define if database is zonal or regional"
  type        = string
}

variable "engine_version" {
  description = "The version of PostgreSQL engine."
  type        = string
  default     = "POSTGRES_14"
}

variable "tier" {
  description = "The database tier (db-f1-micro, db-custom-cpu-ram)"
  type        = string
  default     = "db-f1-micro"
}

variable "disk_limit" {
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
  default     = {}
  type        = any
}

variable "replicas" {
  description = "replicas"
  type        = map(any)
  default     = {}
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

variable "database_flags" {
  description = "Database configuration"
  type        = list(object({
    name  = string
    value = string
  }))
  default     = []
}

variable "private" {
  description = "Set to true if the master instance should also have a public IP (less secure)."
  type        = bool
  default     = true
}

variable "require_ssl" {
  description = "Set to false if you don not want to enforce SSL (less secure)."
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
  default     = null
}

variable "create_secrets" {
  description = "Do we create the secrets in secret manager?"
  type        = bool
  default     = true
}

variable "labels" {
  description = "Labels to add to the CloudSQL and its replicas"
  type        = map(string)
  default     = {}
}

variable "encryption_key_name" {
  description = "KMS key to be used to encrypt database disk"
  type        = string
  default     = ""
}
