# Example of code for deploying a private PostgreSQL DB with a peering between your private subnet and cloudsql service.
# To access to your DB, you need a bastion or a VPN connection from your client.
locals {
  project_id = "padok-cloud-factory"
}

provider "google" {
  project = local.project_id
  region  = "europe-west3"
}

provider "google-beta" {
  project = local.project_id
  region  = "europe-west3"
}

module "my_network" {
  source = "git@github.com:padok-team/terraform-google-network.git?ref=v3.0.0"

  name       = "my-network-1"
  project_id = local.project_id

  subnets = {
    "my-private-subnet-1" = {
      name             = "my-private-subnet-1"
      region           = "europe-west3"
      primary_cidr     = "10.30.0.0/16"
      serverless_cidr  = ""
      secondary_ranges = {}
    }
  }
  gcp_peering_cidr = "10.0.17.0/24"
}

module "my-private-postgresql-db" {
  source = "../../modules/postgresql"

  name           = "my-private-postgres-db1" # Mandatory
  engine_version = "POSTGRES_11"             # Mandatory
  project_id     = local.project_id          # Mandatory
  location       = "europe-west1-b"          # Mandatory

  disk_limit = 20

  users          = ["User_1", "User_2"]
  create_secrets = true

  backup_configuration = {
    enabled  = true
    location = "europe-west3"
  }

  databases = ["MYDB_1"]

  private_network = module.my_network.compute_network.id
}
