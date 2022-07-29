# Example of code for deploying a public PostgreSQL DB with 0 replicas
# We also create two users : Kylian & Antoine (with strong passwords auto-generated)
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

module "my-public-postgresql-db" {
  source = "../../modules/postgresql"

  name           = "my-public-db1"  # Mandatory
  engine_version = "POSTGRES_11"    # Mandatory
  project_id     = local.project_id # Mandatory
  zone           = "europe-west1-b" # Mandatory
  region         = "europe-west1"

  nb_cpu = 2
  ram    = 4096

  disk_size = 10
  disk_autoresize_limit = 20

  nb_replicas = 0

  additional_users = ["Kylian", "Antoine"]

  additional_databases = [
    {
      name : "MYDB_1"
      charset : "utf8"
      collation : "en_US.UTF8"
    }
  ]
  vpc_network = "default-europe-west1"

  assign_public_ip = true

  private_network = null

  #require_ssl = false   // By default, you need a valid certificate to connect to the DB as SSL is enabled. If you do not want this, uncomment this line.
}
