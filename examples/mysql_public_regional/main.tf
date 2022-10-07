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
  source = "git@github.com:padok-team/terraform-google-network.git?ref=v3.0.0"

  name       = "my-network-4"
  project_id = local.project_id

  subnets = {
    "my-private-subnet-4" = {
      name             = "my-private-subnet-4"
      region           = "europe-west3"
      primary_cidr     = "10.33.0.0/16"
      serverless_cidr  = ""
      secondary_ranges = {}
    }
  }
  gcp_peering_cidr = "10.0.20.0/24"
}

module "my-public-mysql-db" {
  source = "../../modules/mysql"

  name              = "my-public-mysql-db1" # Mandatory
  engine_version    = "MYSQL_8_0"           # Mandatory
  project_id        = local.project_id      # Mandatory
  region            = "europe-west1"        # Mandatory
  availability_type = "REGIONAL"

  disk_limit = 20

  users          = ["User_1", "User_2"]
  create_secrets = true

  backup_configuration = {
    enabled  = true
    location = "europe-west3"
  }

  databases = ["MYDB_1"]

  private_network = module.my_network.network_id

  public = true
}
