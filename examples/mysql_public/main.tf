# Example of code for deploying a public MySQL DB with a peering between your private subnet and cloudsql service.

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

  name = "my-network-4"
  subnets = {
    "my-private-subnet-4" = {
      cidr   = "10.33.0.0/16"
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

module "my-public-mysql-db" {
  source = "../../modules/mysql"

  name           = "my-public-mysql-db1" # Mandatory
  engine_version = "MYSQL_8_0"           # Mandatory
  project_id     = local.project_id      # Mandatory
  location       = "europe-west1-b"      # Mandatory

  disk_limit = 20

  additional_users = ["User_1", "User_2"]
  create_secrets   = true

  backup_configuration = {
    enabled  = true
    location = "europe-west3"
  }

  additional_databases = ["MYDB_1"]

  private_network = module.my_network.compute_network.id

  public = true
}
