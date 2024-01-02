terraform {

  required_version = ">= 1.0.0"
  #   backend "gcs" {
  #     bucket = "terraform-backend"
  #     prefix = "terraform/dev/application/state"
  #   }
  required_providers {
    # kubectl = {
    #   source  = "gavinbunney/kubectl"
    #   version = ">= 1.7.0"
    # }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }
    google = {
      version = ">= 5.0.0"
    }
  }
}
# provider "kubernetes" {
#   host                   = "https://${module.gke-dev.endpoint}"
#   cluster_ca_certificate = base64decode(module.gke-dev.ca_certificate)
# }

# provider "google" {
#   project     = local.project_id
#   region      = "us-central1"
# }

