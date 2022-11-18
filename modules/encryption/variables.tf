variable "name" {
  description = "The name of the key ring."
  type        = string
}

variable "region" {
  description = "Region in which the key ring will be located."
  type        = string
  validation {
    condition     = length(split("-", var.region)) == 2
    error_message = "This is not a region."
  }
}

variable "encryption_key_id" {
  description = "The full path to the encryption key used for the CMEK disk encryption. The provided key must be in the same region as the SQL instance. If not provided, a KMS key will be generated."
  type        = string
  default     = null
}

variable "encryption_key_rotation_period" {
  description = "The encryption key rotation period for the CMEK disk encryption. The provided key must be in the same region as the SQL instance. If encryption_key_id is defined, this variable is not used."
  type        = string
  default     = "7889400s" # 3 months
}
