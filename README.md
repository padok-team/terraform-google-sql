# SQL Terraform module

Terraform module which creates **SQL** resources, secrets and backups on **GCP**. This module uses the [sql-db module](https://registry.terraform.io/modules/GoogleCloudPlatform/sql-db/google/latest) by GoogleCloudPlatform.

## User Stories for this module

- AASQL / POSTGRES INSTANCE I can be highly available or single zone
- AASQL / POSTGRES INSTANCE I can be fully private or have a public ip
- AASQL / POSTGRES INSTANCE I can have db users and store their passwords in secret manager
- AASQL / POSTGRES INSTANCE I can have multiple dbs
- AASQL / POSTGRES INSTANCE I can have custom exporter to schedule backups in a bucket

## Usage

```hcl
module "example" {
  source = "https://github.com/padok-team/terraform-aws-example"

  example_of_required_variable = "hello_world"
}
```

## Examples

- [MySQL instance private and zonal](examples/example_of_use_case/main.tf)
- [MySQL instance private, zonal with backup](examples/example_of_other_use_case/main.tf)
- [MySQL instance public, regional](examples/example_of_other_use_case/main.tf)
- [MySQL instance private, zonal with backup](examples/example_of_other_use_case/main.tf)
- [MySQL instance private, zonal with backup](examples/example_of_other_use_case/main.tf)




<!-- BEGIN_TF_DOCS -->
## Modules

No modules.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_example_of_required_variable"></a> [example\_of\_required\_variable](#input\_example\_of\_required\_variable) | Short description of the variable | `string` | n/a | yes |
| <a name="input_example_with_validation"></a> [example\_with\_validation](#input\_example\_with\_validation) | Short description of the variable | `list(string)` | n/a | yes |
| <a name="input_example_of_variable_with_default_value"></a> [example\_of\_variable\_with\_default\_value](#input\_example\_of\_variable\_with\_default\_value) | Short description of the variable | `string` | `"default_value"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_example"></a> [example](#output\_example) | A meaningful description |
<!-- END_TF_DOCS -->
