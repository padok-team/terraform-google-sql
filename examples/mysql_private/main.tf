# Example of code for deploying a private MySQL DB with 2 replicas, and a peering between your private subnet and cloudsql service.
# We also create two users : Kylian & Antoine (with strong passwords auto-generated)
# To access to your DB, you need a bastion or a VPN connection from your client.
locals {
  project_id = "padok-lab"
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
  name   = "my-network-1"
  subnets = {
    "my-private-subnet-1" = {
      cidr   = "10.30.0.0/16"
      region = "europe-west3"
    }
  }
  peerings = {
    cloudsql = {
      address = "10.0.17.0"
      prefix  = 24
    }
  }
}


module "my-private-mysql-db" {
  source = "../../modules/mysql"

  name           = "my-private-db3" #mandatory
  engine_version = "MYSQL_5_6"      #mandatory
  project_id     = local.project_id #mandatory
  region         = "europe-west1"
  zone           = "europe-west1-b" #mandatory

  nb_cpu = 2
  ram    = 4096

  disk_size = 10
  disk_autoresize_limit = 20

  nb_replicas = 2

  additional_users = ["Kylian", "Antoine"]

  additional_databases = [
    {
      name : "MYDB_1"
      charset : "utf8"
      collation : "utf8_general_ci"
    }
  ]
  vpc_network = "default-europe-west1"

  private_network = module.my_network.compute_network.id
  
  allocated_ip_range = "my-network-1-cloudsql"
}
