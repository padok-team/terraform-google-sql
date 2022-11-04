variable "name" {
  description = "The name of the Cloud SQL resource."
  type        = string
}

variable "project_id" {
  description = "The project ID to manage the Cloud SQL resource."
  type        = string
}

variable "region" {
  description = "Region for the master instance"
  type        = string
  validation {
    condition     = length(split("-", var.region)) == 2
    error_message = "This is not a region"
  }
}

variable "availability_type" {
  description = "Is CloudSQL instance Regional or Zonal correct values = (REGIONAL|ZONAL)"
  type        = string
  validation {
    condition     = var.availability_type == "REGIONAL" || var.availability_type == "ZONAL"
    error_message = "availability_type only supports REGIONAL or ZONAL"
  }
  default = "REGIONAL"
}

variable "engine_version" {
  description = "The version of PostgreSQL engine. Check https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance#database_version for possible versions."
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

variable "disk_type" {
  description = "The disk type (PD_SSD, PD_HDD)."
  type        = string
  default     = "PD_SSD"
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

variable "instance_deletion_protection" {
  description = "Used to block Terraform from deleting a SQL Instance."
  type        = bool
  default     = false
}

variable "databases" {
  description = "List of the default DBs you want to create."
  type = map(object({
    export_backup   = bool
    export_schedule = optional(string, "0 2 * * *")
  }))
  default = {}
}

variable "users" {
  description = "List of the User's name you want to create (passwords will be auto-generated). Warning! All those users will be admin and have access to all databases created with this module."
  type        = list(string)
}

variable "database_flags" {
  description = "Database configuration"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "public" {
  description = "Set to true if the master instance should also have a public IP (less secure)."
  type        = bool
  default     = false
}

variable "require_ssl" {
  description = "Set to false if you don not want to enforce SSL (less secure)."
  type        = bool
  default     = true
}

variable "private_network" {
  description = "The vpc id."
  type        = string
  default     = null
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

variable "sql_exporter" {
  description = "The SQL exporter to use for backups if needed."
  type = object({
    bucket_name  = string
    pubsub_topic = string
    timezone     = optional(string, "UTC")
  })
  default = null
}
