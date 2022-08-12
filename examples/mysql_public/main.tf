# Example of code for deploying a public MySQL DB with 0 replica
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

module "my-public-mysql-db" {
  source = "../../modules/mysql"

  name           = "my-public-db1"  #mandatory
  engine_version = "MYSQL_5_6"      #mandatory
  project_id     = local.project_id #mandatory
  region         = "europe-west1"
  zone           = "europe-west1-b" #mandatory

  nb_cpu = 2
  ram    = 4096

  disk_size             = 10
  disk_autoresize_limit = 20

  nb_replicas = 0

  additional_users = ["Kylian", "Antoine"]

  additional_databases = [
    {
      name : "MYDB_1"
      charset : "utf8"
      collation : "utf8_general_ci"
    }
  ]
  vpc_network = "default-europe-west1"

  assign_public_ip = true

  private_network = null

  #require_ssl = false   // By default, you must have a valid certificate to get connected to the DB as SSL is enabled. If you do not want, uncomment this line.

  create_secrets = true
}
