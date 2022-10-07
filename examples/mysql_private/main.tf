# Example of code for deploying a private MySQL DB with a peering between your private subnet and cloudsql service.
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

  name = "my-network-3"
  subnets = {
    "my-private-subnet-3" = {
      cidr   = "10.32.0.0/16"
      region = "europe-west3"
    }
  }
  peerings = {
    cloudsql = {
      address = "10.0.19.0"
      prefix  = 24
    }
  }
}

module "my-private-mysql-db" {
  source = "../../modules/mysql"

  name           = "my-private-mysql-db1" # Mandatory
  engine_version = "MYSQL_8_0"            # Mandatory
  project_id     = local.project_id       # Mandatory
  location       = "europe-west1-b"       # Mandatory

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
