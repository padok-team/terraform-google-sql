terraform {
  required_version = "~> 1.3"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.4"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}
