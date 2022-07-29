# Google Cloud SQL (MySQL) Terraform module

Terraform module which creates **MYSQLDB** resources on **GCP**. This module is an abstraction of the [terraform-google-sql for MySQL](https://github.com/terraform-google-modules/terraform-google-sql-db/tree/master/modules/mysql) by Google itself.

## User Stories for this module

- AAUser I can deploy a public MySQL Database
- AAUser I can deploy a private MySQL Database within a VPC
- AAUser I can deploy a public/private MySQL Database with N replica
- AAUser I can deploy a public/private MySQL Database with/without TLS encryption

<em>By default, deployed Database is in HA mode, with a 7 retention days backup strategy.</em>
## Usage

```hcl
module "my-public-mysql-db" {
  source = "https://github.com/padok-team/terraform-google-cloudsql-mysql"

  name           = "my-public-db1"  #mandatory
  engine_version = "MYSQL_5_6"      #mandatory
  project_id     = local.project_id #mandatory
  region         = "europe-west1"
  zone           = "europe-west1-b" #mandatory

  nb_cpu = 2
  ram    = 4096

  disk_size = 10

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
}
```

## Examples

- [Example of public MySQL DB](examples/public_mysql_db/main.tf)
- [Example of private MySQL DB](examples/private_mysql_db/main.tf)

<!-- BEGIN_TF_DOCS -->
## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_mysql-db"></a> [mysql-db](#module\_mysql-db) | GoogleCloudPlatform/sql-db/google//modules/mysql | 8.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_databases"></a> [additional\_databases](#input\_additional\_databases) | List of the default DBs you want to create. | <pre>list(object({<br>    name      = string<br>    charset   = string<br>    collation = string<br>  }))</pre> | n/a | yes |
| <a name="input_additional_users"></a> [additional\_users](#input\_additional\_users) | List of the User's name you want to create (passwords will be auto-generated). Warning! All those users will be admin and have access to all databases created with this module. | `list(string)` | n/a | yes |
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | Size of the db disk (in Gb). | `number` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the Cloud SQL resource. | `string` | n/a | yes |
| <a name="input_nb_cpu"></a> [nb\_cpu](#input\_nb\_cpu) | Number of virtual processors. | `number` | n/a | yes |
| <a name="input_private_network"></a> [private\_network](#input\_private\_network) | Define the CIDR of your private network. | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The project ID to manage the Cloud SQL resource. | `string` | n/a | yes |
| <a name="input_ram"></a> [ram](#input\_ram) | Quantity of RAM (in Mb). | `number` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region for the master instance, it should be something like: us-central1-a, us-east1-c, etc. | `string` | n/a | yes |
| <a name="input_vpc_network"></a> [vpc\_network](#input\_vpc\_network) | Name of the VPC within the instance SQL is deployed. | `string` | n/a | yes |
| <a name="input_zone"></a> [zone](#input\_zone) | The zone for the master instance, it should be something like: us-central1-a, us-east1-c, etc. | `string` | n/a | yes |
| <a name="input_assign_public_ip"></a> [assign\_public\_ip](#input\_assign\_public\_ip) | Set to true if the master instance should also have a public IP (less secure). | `bool` | `false` | no |
| <a name="input_backup_configuration"></a> [backup\_configuration](#input\_backup\_configuration) | The backup\_configuration settings subblock for the database setings. | `map` | <pre>{<br>  "binary_log_enabled": false,<br>  "enabled": false,<br>  "retained_backups": 7,<br>  "retention_unit": "COUNT",<br>  "start_time": "03:00",<br>  "transaction_log_retention_days": "7"<br>}</pre> | no |
| <a name="input_db_charset"></a> [db\_charset](#input\_db\_charset) | Charset for the DB. | `string` | `"utf8"` | no |
| <a name="input_db_collation"></a> [db\_collation](#input\_db\_collation) | Collation for the DB. | `string` | `"utf8_general_ci"` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | The version of MySQL engine. | `string` | `"MYSQL_5_6"` | no |
| <a name="input_ha_external_ip_range"></a> [ha\_external\_ip\_range](#input\_ha\_external\_ip\_range) | The ip range to allow connecting from/to Cloud SQL. | `string` | `"192.10.10.10/32"` | no |
| <a name="input_high_availability"></a> [high\_availability](#input\_high\_availability) | Activate or not high availability for your DB. | `bool` | `true` | no |
| <a name="input_instance_deletion_protection"></a> [instance\_deletion\_protection](#input\_instance\_deletion\_protection) | Used to block Terraform from deleting a SQL Instance. | `bool` | `false` | no |
| <a name="input_nb_replicas"></a> [nb\_replicas](#input\_nb\_replicas) | Number of read replicas you need. | `number` | `0` | no |
| <a name="input_require_ssl"></a> [require\_ssl](#input\_require\_ssl) | Set to false if you do not want to enforce SSL (less secure). | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_additional_users"></a> [additional\_users](#output\_additional\_users) | List of maps of additional users and passwords. |
| <a name="output_instance_connection_name"></a> [instance\_connection\_name](#output\_instance\_connection\_name) | The connection name of the master instance to be used in connection strings. |
| <a name="output_instance_name"></a> [instance\_name](#output\_instance\_name) | The instance name for the master instance. |
| <a name="output_private_ip_address"></a> [private\_ip\_address](#output\_private\_ip\_address) | The first private IPv4 address assigned for the master instance. |
| <a name="output_public_ip_address"></a> [public\_ip\_address](#output\_public\_ip\_address) | The first public (PRIMARY) IPv4 address assigned for the master instance. |
| <a name="output_read_replica_instance_names"></a> [read\_replica\_instance\_names](#output\_read\_replica\_instance\_names) | The instance names for the read replica instances. |
<!-- END_TF_DOCS -->

## License

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

See [LICENSE](LICENSE) for full details.

```text
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

  https://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
```
