terraform {
  required_version = "~> 1.3"

  required_providers {
    google = {
      version = "~> 4.11"
    }
    random = {
      source  = "hasicorp/random"
      version = "~> 3"
    }
  }
}
