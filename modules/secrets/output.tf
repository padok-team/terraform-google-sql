locals {
  users_passwords = [
    for user in var.users : {
      name     = user
      password = random_password.password[user].result
    }
  ]
}

output "users_passwords" {
  description = "The map of users and their passwords."
  value       = local.users_passwords
}