# Terraform version
terraform {
  required_version = ">= 1.6.4"

  required_providers {
      kubectl = {
        source  = "gavinbunney/kubectl"
        version = ">= 1.7.0"
      }
      kubernetes = {
        source  = "hashicorp/kubernetes"
        version = ">= 2.0.0"
      }
      google = {
        source  = "hashicorp/google"
        version = ">= 5.10.0"
      }
    }
  }
provider "kubernetes" {
  host                   = "https://${module.gke-dev.endpoint}"
  cluster_ca_certificate = base64decode(module.gke-dev.ca_certificate)
}