locals {
  name            = "helm-addons"
  region          = "us-central1"
  cluster_version = "1.29.0-gke.1381000"
  gcp_project_id  = "dev-env-3b53"
  tags = {
    Name        = local.name
    GithubRepo  = "terraform-helm-gke-addons"
    GithubOrg   = "clouddrove"
  }
}