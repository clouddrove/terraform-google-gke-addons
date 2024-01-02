


provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

# provider "google" {
#   project = local.project_id
#   region  = "us-central1"
# }

provider "google-beta" {
  project = local.project_id
  region  = "us-central1"
}

