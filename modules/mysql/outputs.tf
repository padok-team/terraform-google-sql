output "instance_name" {
  description = "The instance name for the master instance."
  value       = module.mysql-db.instance_name
}

output "instance_connection_name" {
  description = "The connection name of the master instance to be used in connection strings."
  value       = module.mysql-db.instance_connection_name
}

output "read_replica_instance_names" {
  description = "The instance names for the read replica instances."
  value       = module.mysql-db.read_replica_instance_names
}

output "public_ip_address" {
  description = "The first public (PRIMARY) IPv4 address assigned for the master instance."
  value       = module.mysql-db.public_ip_address
}

output "private_ip_address" {
  description = "The first private IPv4 address assigned for the master instance."
  value       = module.mysql-db.private_ip_address
}

output "additional_users" {
  description = "List of maps of additional users and passwords."
  value = [for r in module.mysql-db.additional_users :
    {
      name     = r.name
      password = r.password
    }
  ]
  sensitive = true
}
