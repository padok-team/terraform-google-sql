# Google Cloud SQL (PostgreSQL) Terraform module

Terraform module which creates **POSTGRESQLDB** resources on **GCP**. This module is an abstraction of the [terraform-google-sql for PostgreSQL](https://github.com/terraform-google-modules/terraform-google-sql-db/tree/master/modules/postgresql) by Google itself.

## User Stories for this module

- AAUser I can deploy a public PostgreSQL Database
- AAUser I can deploy a private PostgreSQL Database within a VPC
- AAUser I can deploy a PostgreSQL Database with N replica
- AAUser I can deploy a PostgreSQL Database with/without TLS encryption
- AAUser I can deploy a cloud scheduler which launches exports with an already existing pubsub function
- AAUser I can encrypt the database with my own encryption key

<em>By default, deployed Database is in HA mode, with a 7 retention days backup strategy.</em>

## Usage

```hcl
module "my-private-postgresql-db" {
  source = "https://github.com/padok-team/terraform-google-sql/modules/postgresql"

  name              = "my-private-postgres-db1" # Mandatory
  engine_version    = "POSTGRES_11"             # Mandatory
  project_id        = local.project_id          # Mandatory
  region            = "europe-west1"            # Mandatory
  availability_type = "REGIONAL"

  disk_limit = 20

  users          = ["User_1", "User_2"]
  create_secrets = true

  backup_configuration = {
    enabled  = true
    location = "europe-west3"
  }

  databases = {
    "MYDB_1" = {
      backup = false
    }
  }

  private_network = module.my_network.network_id

  custom_sql_script = <<EOT
ALTER ROLE "User_1" NOCREATEDB;
ALTER ROLE "User_1" NOCREATEROLE;
REVOKE cloudsqlsuperuser from "User_1";
EOT
}
```

## Execute your SQL script

If you have set a custom sql script, you need to execute it. As for now, terraform doesn't allow to execute the sql script, you need to use the [gcloud command instead](https://cloud.google.com/sdk/gcloud/reference/sql/import/sql)

```bash
gcloud sql import sql my-private-postgres-db1 MY-BUCKET --database=postgres --project=MY-PROJECT -q
```

## Examples

- [POSTGRES instance private and regional](examples/postgresql_private_regional)
- [POSTGRES instance public and zonal](examples/postgresql_public_zonal)
- [POSTGRES instance public, regional, with backup](examples/postgresql_private_with_exporter)

<!-- BEGIN_TF_DOCS -->
## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_encryption"></a> [encryption](#module\_encryption) | ../encryption | n/a |
| <a name="module_postgresql-db"></a> [postgresql-db](#module\_postgresql-db) | GoogleCloudPlatform/sql-db/google//modules/postgresql | 22.1.0 |
| <a name="module_secrets"></a> [secrets](#module\_secrets) | ../secrets | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_disk_limit"></a> [disk\_limit](#input\_disk\_limit) | The maximum size to which storage can be auto increased. | `number` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the Cloud SQL resource. | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The project ID to manage the Cloud SQL resource. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Region for the master instance. | `string` | n/a | yes |
| <a name="input_users"></a> [users](#input\_users) | List of the User's name you want to create (passwords will be auto-generated). Warning! All those users will be admin and have access to all databases created with this module. | `list(string)` | n/a | yes |
| <a name="input_allocated_ip_range"></a> [allocated\_ip\_range](#input\_allocated\_ip\_range) | The name of the allocated ip range for the private ip CloudSQL instance. For example: "google-managed-services-default". If set, the instance ip will be created in the allocated range. | `string` | `null` | no |
| <a name="input_availability_type"></a> [availability\_type](#input\_availability\_type) | Is CloudSQL instance Regional or Zonal correct values = (REGIONAL\|ZONAL). | `string` | `"REGIONAL"` | no |
| <a name="input_backup_configuration"></a> [backup\_configuration](#input\_backup\_configuration) | The backup\_configuration settings subblock for the database setings. | `any` | `{}` | no |
| <a name="input_create_secrets"></a> [create\_secrets](#input\_create\_secrets) | Do we create the secrets in secret manager? | `bool` | `true` | no |
| <a name="input_custom_sql_script"></a> [custom\_sql\_script](#input\_custom\_sql\_script) | sql script to execute | `string` | `""` | no |
| <a name="input_database_flags"></a> [database\_flags](#input\_database\_flags) | Database configuration flags. | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | `[]` | no |
| <a name="input_databases"></a> [databases](#input\_databases) | List of the default DBs you want to create. | <pre>map(object({<br>    export_backup   = bool<br>    export_schedule = optional(string, "0 2 * * *")<br>  }))</pre> | `{}` | no |
| <a name="input_db_charset"></a> [db\_charset](#input\_db\_charset) | Charset for the DB. | `string` | `"utf8"` | no |
| <a name="input_db_collation"></a> [db\_collation](#input\_db\_collation) | Collation for the DB. | `string` | `"en_US.UTF8"` | no |
| <a name="input_disk_type"></a> [disk\_type](#input\_disk\_type) | The disk type (PD\_SSD, PD\_HDD). | `string` | `"PD_SSD"` | no |
| <a name="input_encryption_key_id"></a> [encryption\_key\_id](#input\_encryption\_key\_id) | The full path to the encryption key used for the CMEK disk encryption. The provided key must be in the same region as the SQL instance. If not provided, a KMS key will be generated. | `string` | `null` | no |
| <a name="input_encryption_key_rotation_period"></a> [encryption\_key\_rotation\_period](#input\_encryption\_key\_rotation\_period) | The encryption key rotation period for the CMEK disk encryption. The provided key must be in the same region as the SQL instance. If encryption\_key\_id is defined, this variable is not used. | `string` | `"7889400s"` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | The version of PostgreSQL engine. Check https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance#database_version for possible versions. | `string` | `"POSTGRES_14"` | no |
| <a name="input_instance_deletion_protection"></a> [instance\_deletion\_protection](#input\_instance\_deletion\_protection) | Used to block Terraform from deleting a SQL Instance. | `bool` | `false` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Labels to add to the CloudSQL and its replicas. | `map(string)` | `{}` | no |
| <a name="input_private_network"></a> [private\_network](#input\_private\_network) | The vpc id to create the instance into. | `string` | `null` | no |
| <a name="input_public"></a> [public](#input\_public) | Set to true if the master instance should also have a public IP (less secure). | `bool` | `false` | no |
| <a name="input_replica_disk_size"></a> [replica\_disk\_size](#input\_replica\_disk\_size) | The disk size of the replica instance in GB. | `number` | `10` | no |
| <a name="input_replicas"></a> [replicas](#input\_replicas) | The replicas instance names and configuration. | `map(any)` | `{}` | no |
| <a name="input_sql_exporter"></a> [sql\_exporter](#input\_sql\_exporter) | The SQL exporter to use for backups if needed. | <pre>object({<br>    bucket_name  = string<br>    pubsub_topic = string<br>    timezone     = optional(string, "UTC")<br>  })</pre> | `null` | no |
| <a name="input_ssl_mode"></a> [ssl\_mode](#input\_ssl\_mode) | Set to false if you don not want to enforce SSL (less secure). | `string` | `"ENCRYPTED_ONLY"` | no |
| <a name="input_tier"></a> [tier](#input\_tier) | The database tier (db-f1-micro, db-custom-cpu-ram). | `string` | `"db-f1-micro"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_connection_name"></a> [instance\_connection\_name](#output\_instance\_connection\_name) | The connection name of the master instance to be used in connection strings. |
| <a name="output_instance_name"></a> [instance\_name](#output\_instance\_name) | The instance name for the master instance. |
| <a name="output_private_ip_address"></a> [private\_ip\_address](#output\_private\_ip\_address) | The first private IPv4 address assigned for the master instance. |
| <a name="output_public_ip_address"></a> [public\_ip\_address](#output\_public\_ip\_address) | The first public (PRIMARY) IPv4 address assigned for the master instance. |
| <a name="output_read_replica_instance_names"></a> [read\_replica\_instance\_names](#output\_read\_replica\_instance\_names) | The instance names for the read replica instances. |
| <a name="output_secrets"></a> [secrets](#output\_secrets) | The secrets created for the users. |
| <a name="output_users"></a> [users](#output\_users) | List of maps of users and passwords. |
<!-- END_TF_DOCS -->
