terraform {
  required_version = ">= 1.6.4"

  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.4.1"
    }
    google = {
      source  = "hashicorp/google"
      version = ">= 5.10.0"
    }
  }
}