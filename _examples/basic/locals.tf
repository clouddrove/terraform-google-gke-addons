locals {
  name            = "helm-addons"
  environment     = "test"
  region          = "us-central1"
  cluster_version = "1.28.3-gke.1203001"
  gcp_project_id  = "dev-env-3b53"
  cluster_name    = "addons-cluster"
  tags = {
    Name        = local.name
    Environment = local.environment
    GithubRepo  = "terraform-helm-gke-addons"
    GithubOrg   = "clouddrove"
  }
}