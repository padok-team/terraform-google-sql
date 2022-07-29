# Example of code for deploying a private PostgreSQL DB with 2 replicas, and a peering between your private subnet and cloudsql service.
# We also create two users : Kylian & Antoine (with strong passwords auto-generated)
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
  source = "git@github.com:padok-team/terraform-google-network.git?ref=v2.0.3"

  name = "my-network-1"
  subnets = {
    "my-private-subnet-1" = {
      cidr   = "10.31.0.0/16"
      region = "europe-west3"
    }
  }
  peerings = {
    cloudsql = {
      address = "10.0.18.0"
      prefix  = 24
    }
  }
}


module "my-private-postgresql-db" {
  source = "../../modules/postgresql"

  name           = "my-private-db1" # Mandatory
  engine_version = "POSTGRES_11"    # Mandatory
  project_id     = local.project_id # Mandatory
  zone           = "europe-west1-b" # Mandatory
  region         = "europe-west1"

  nb_cpu = 2
  ram    = 4096

  disk_size = 10
  disk_autoresize_limit = 20

  nb_replicas = 1

  additional_users = ["Kylian", "Antoine"]

  additional_databases = [
    {
      name : "MYDB_1",
      charset : "utf8"
      collation : "en_US.UTF8"
    }
  ]
  vpc_network = "default-europe-west1"

  private_network = module.my_network.compute_network.id

  create_secrets = true
}
