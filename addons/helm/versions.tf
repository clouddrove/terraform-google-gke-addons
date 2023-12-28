terraform {
  required_version = ">= 1.0.0"

  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.4.1"
    }
    google = {
      source  = "hashicorp/google"
      version = ">= 3.72"
    }
  }
}