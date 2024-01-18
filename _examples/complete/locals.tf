locals {
  name            = "helm-addons-test-1"
  environment     = "test"
  region          = "us-central1"
  cluster_version = "1.28.3-gke.1203001"
  gcp_project_id  = "dev-env-3b53"
  cluster_name    = "test-cluster"
  tags = {
    Name        = local.name
    Environment = local.environment
    GithubRepo  = "terraform-helm-gke-addons"
    GithubOrg   = "clouddrove"
  }
}