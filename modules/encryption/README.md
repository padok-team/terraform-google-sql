# Google Cloud SQL (Encyrption) Terraform module

Terraform module which creates **necessary IAM resources** for encryption and optionally **encryption key** resources on **Google Cloud Provider** related to SQL databases created with the other modules of this repository.

## User Stories for this module

- AASRE my database is encrypted with a managed KMS key
- AASRE my database is encrypted with an external key

## Usage

This module is used in [mysql module](../mysql/) and [postgresql module](../postgresql/) to create necessary IAM resources for encryption and optionally encryption key resources in KMS.

<!-- BEGIN_TF_DOCS -->
## Modules

No modules.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | The name of the key ring. | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The project ID to manage the Cloud SQL resource. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Region in which the key ring will be located. | `string` | n/a | yes |
| <a name="input_encryption_key_id"></a> [encryption\_key\_id](#input\_encryption\_key\_id) | The full path to the encryption key used for the CMEK disk encryption. The provided key must be in the same region as the SQL instance. If not provided, a KMS key will be generated. | `string` | `null` | no |
| <a name="input_encryption_key_rotation_period"></a> [encryption\_key\_rotation\_period](#input\_encryption\_key\_rotation\_period) | The encryption key rotation period for the CMEK disk encryption. The provided key must be in the same region as the SQL instance. If encryption\_key\_id is defined, this variable is not used. | `string` | `"7889400s"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_key_id"></a> [key\_id](#output\_key\_id) | The id of encryption key. |
<!-- END_TF_DOCS -->