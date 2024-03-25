locals {
  name            = "helm-addons"
  environment     = "test"
  region          = "us-central1"
  cluster_version = "1.29.1-gke.1589017"
  gcp_project_id  = "cloud-crew-testing"

  tags = {
    Name        = local.name
    Environment = local.environment
    GithubRepo  = "terraform-helm-gke-addons"
    GithubOrg   = "clouddrove"
  }
}