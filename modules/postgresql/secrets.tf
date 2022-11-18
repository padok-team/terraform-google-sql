# Passwords
module "secrets" {
  source = "../secrets"

  project_id     = var.project_id
  instance_name  = var.name
  users          = var.users
  region         = var.region
  create_secrets = var.create_secrets
}