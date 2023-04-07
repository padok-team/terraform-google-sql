# SQL Terraform module

Terraform module which creates **SQL** resources, secrets and backups on **GCP**. This module uses the [sql-db module](https://registry.terraform.io/modules/GoogleCloudPlatform/sql-db/google/latest) by GoogleCloudPlatform.

## User Stories for this module

- AASQL / POSTGRES INSTANCE I can be highly available or single zone
- AASQL / POSTGRES INSTANCE I can be fully private or have a public ip
- AASQL / POSTGRES INSTANCE I can have db users and store their passwords in secret manager
- AASQL / POSTGRES INSTANCE I can have multiple dbs
- AASQL / POSTGRES INSTANCE I can have custom exporter to schedule backups in a bucket
- AASQL / POSTGRES INSTANCE I use can use custom managed keys to encrypt my disk

## Usage

### Databases

You can use either mysql or postgresql module to create databases instances in GCP. These modules optionnally include [secrets](modules/secrets) module to create secrets in google secret manager with password values for each user.

### SQL Exporter

This module creates a storage bucket and a cloud function to export database backups in buckets. In order to schedule backups on a regular basis, you need to create a cloud scheduler outside of the sql exporter module. In [mysql](modules/mysql) and [postgresql](modules/postgresql) modules, you can optionnally enable and configure these schedulers for each databases.

:warning: Althought we do not recommend creating different databases in the same instance, simultaneous backups for databases in the same instance. If you are in this situation, please be careful to schedule backups for your databases apart from each other to avoid failed backups.

## Examples

Examples can be found in the examples folder. You might need to run `terraform apply` twice because of a race condition with the network. This would not be needed in normal configurations as the network would be created somewhere else.

- [MySQL instance private and zonal](examples/mysql_private_zonal)
- [MySQL instance public and regional](examples/mysql_public_regional)
- [MySQL instance public, zonal, with backup exporter](examples/mysql_public_with_exporter)
- [POSTGRES instance private and regional](examples/postgresql_private_regional)
- [POSTGRES instance public and zonal](examples/postgresql_public_zonal)
- [POSTGRES instance public, regional, with backup](examples/postgresql_private_with_exporter)

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
