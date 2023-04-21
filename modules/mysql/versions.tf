terraform {
  required_version = "~> 1.3"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.4"
    }
    random = {
      source  = "hasicorp/random"
      version = "~> 3"
    }
  }
}
