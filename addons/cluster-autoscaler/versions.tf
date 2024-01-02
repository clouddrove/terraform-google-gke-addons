terraform {
  required_version = ">= 0.13.0"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.10"
    }
    google = {
      version = ">= 5.0.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = "us-central1"
}
