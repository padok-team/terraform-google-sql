# Example of code for deploying a public PostgreSQL DB with a peering between your private subnet and cloudsql service.

locals {
  project_id = "library-344516"
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
  source = "github.com/padok-team/terraform-google-network?ref=v4.3.0"

  name       = "my-network-2"
  project_id = local.project_id

  subnets = {
    "my-private-subnet-2" = {
      name             = "my-private-subnet-2"
      region           = "europe-west3"
      primary_cidr     = "10.31.0.0/16"
      serverless_cidr  = ""
      secondary_ranges = {}
    }
  }
  gcp_peering_cidr = "10.0.18.0/24"
}

module "my-public-postgresql-db" {
  source = "../../modules/postgresql"

  name              = "my-public-postgres-db1" # Mandatory
  engine_version    = "POSTGRES_11"            # Mandatory
  project_id        = local.project_id         # Mandatory
  region            = "europe-west1"           # Mandatory
  availability_type = "ZONAL"
  zone              = "europe-west3-b"

  disk_limit = 20

  users          = ["User_1", "User_2"]
  create_secrets = true

  backup_configuration = {
    enabled  = true
    location = "europe-west3"

    #checkov:skip=CKV2_GCP_20:Ensure MySQL DB instance has point-in-time recovery backup configured
    #Skipped because we don't have a 'start_time' within the backup_configuration
  }

  databases = {
    "MYDB_1" = {
      export_backup = false
    }
  }

  private_network = module.my_network.network_id
  depends_on      = [module.my_network.google_service_networking_connection]

  public                 = true
  init_custom_sql_script = <<EOT
ALTER ROLE "User_1" NOCREATEDB;
ALTER ROLE "User_1" NOCREATEROLE;
REVOKE cloudsqlsuperuser from "User_1";
EOT
}
