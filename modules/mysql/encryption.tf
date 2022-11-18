module "encryption" {
  source = "../encryption"

  name = var.name
  region = var.region

  encryption_key_id = var.encryption_key_id
  encryption_key_rotation_period = var.encryption_key_rotation_period
}
