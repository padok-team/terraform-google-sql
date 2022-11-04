# Google Cloud SQL (Secrets) Terraform module

Terraform module which creates **Secret** resources on **Google Cloud Provider** related to SQL databases created with the other modules of this repository.

## User Stories for this module

- AASRE my database is protected by a strong password
- AASRE I can easily access my database password to connect to it

## Usage

This module is used in [mysql module](../mysql/) and [postgresql module](../postgresql/) to create password for databases and write them in the secret manager.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 4.4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | ~> 4.4 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_secret_manager_secret.password](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret) | resource |
| [google_secret_manager_secret_version.password](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret_version) | resource |
| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_secrets"></a> [create\_secrets](#input\_create\_secrets) | Do we create the secrets in secret manager? | `bool` | `true` | no |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | The name of the Cloud SQL resource. | `string` | n/a | yes |
| <a name="input_labels"></a> [labels](#input\_labels) | The labels to apply to the secrets. | `map(string)` | `{}` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The project ID to manage the Cloud SQL resource. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region for the passwords, it should be something like: us-central1-a, us-east1-c, etc. | `string` | n/a | yes |
| <a name="input_users"></a> [users](#input\_users) | List of the users name and their password to store on secret manager. Warning! All those users will be admin and have access to all databases created with this module. | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_users_passwords"></a> [users\_passwords](#output\_users\_passwords) | The map of users and their passwords. |
<!-- END_TF_DOCS -->