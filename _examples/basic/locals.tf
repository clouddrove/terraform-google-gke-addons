locals {
  name            = "helm-addons"
  environment     = "test"
  region          = "us-central1"
  cluster_version = "1.29.0-gke.1381000"
  gcp_project_id  = "dev-env-3b53"
  cluster_name    = "test-cluster1"
  tags = {
    Name        = local.name
    Environment = local.environment
    GithubRepo  = "terraform-helm-gke-addons"
    GithubOrg   = "clouddrove"
  }
}