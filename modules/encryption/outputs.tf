output "key_id" {
  description = "The id of encryption key."
  value       = var.encryption_key_id == null ? google_kms_crypto_key.this[0].id : var.encryption_key_id
}
