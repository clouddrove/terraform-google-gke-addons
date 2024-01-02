terraform {
  required_version = ">= 0.13.0"

  required_providers {
    google = {
      version = ">= 5.0.0"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.8"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.6"
    }
    # kubectl = {
    #   source  = "gavinbunney/kubectl"
    #   version = ">= 1.7.0"
    # }
    local = {
      source  = "hashicorp/local"
      version = ">= 2.0.0"
    }
  }
}

provider "google" {
  project = local.project_id
  # region  = local.region
}

provider "google-beta" {
  project = local.project_id
  region  = "us-central1"
}
