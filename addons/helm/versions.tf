terraform {
  required_version = ">= 0.13.0"

  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.4.1"
    }
  }
}