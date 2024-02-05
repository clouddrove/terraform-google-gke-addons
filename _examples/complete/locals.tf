locals {
  name            = "helm-addons-test-1"
  environment     = "test"
  region          = "us-central1"
  cluster_version = "latest"
  gcp_project_id  = "dev-env-3b53"
  cluster_name    = "test-cluster1"
  tags = {
    Name        = local.name
    Environment = local.environment
    GithubRepo  = "terraform-helm-gke-addons"
    GithubOrg   = "clouddrove"
  }
}