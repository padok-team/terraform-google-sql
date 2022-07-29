variable "instance_name" {
  description = "The name of the Cloud SQL resource."
  type        = string
}

variable "project_id" {
  description = "The project ID to manage the Cloud SQL resource."
  type        = string
}

variable "labels" {
  type        = map(string)
  default     = {}
  description = "The labels to apply to the secrets."
}

variable "region" {
  description = "The region for the passwords, it should be something like: us-central1-a, us-east1-c, etc."
  type        = string
}

variable "users" {
  description = "List of the users name and their password to store on secret manager. Warning! All those users will be admin and have access to all databases created with this module."
  type        = list(string)
}

variable "create_secrets" {
  description = "Do we create the secrets in secret manager?"
  type        = bool
  default     = true
}


