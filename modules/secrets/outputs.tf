locals {
  users_passwords = [
    for user in var.users : {
      name            = user
      password        = random_password.password[user].result
      random_password = false
    }
  ]
}

output "users_passwords" {
  value       = local.users_passwords
  description = "The map of users and their passwords."
}

output "secrets" {
  value       = google_secret_manager_secret.password
  description = "The secrets created for the users."
  sensitive   = true
}
