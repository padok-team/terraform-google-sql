output "instance_name" {
  description = "The instance name for the master instance."
  value       = module.postgresql-db.instance_name
}

output "instance_connection_name" {
  description = "The connection name of the master instance to be used in connection strings."
  value       = module.postgresql-db.instance_connection_name
}

output "read_replica_instance_names" {
  description = "The instance names for the read replica instances."
  value       = module.postgresql-db.read_replica_instance_names
}

output "public_ip_address" {
  description = "The first public (PRIMARY) IPv4 address assigned for the master instance."
  value       = var.public ? module.postgresql-db.public_ip_address : ""
}

output "private_ip_address" {
  description = "The first private IPv4 address assigned for the master instance."
  value       = module.postgresql-db.private_ip_address
}

output "users" {
  description = "List of maps of users and passwords."
  value = [for r in module.postgresql-db.additional_users :
    {
      name     = r.name
      password = r.password
    }
  ]
  sensitive = true
}

output "secrets" {
  description = "The secrets created for the users."
  value       = module.secrets.secrets
  sensitive = true
}
