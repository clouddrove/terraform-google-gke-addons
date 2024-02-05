locals {
  name            = "helm-addons-test"
  environment     = "test"
  region          = "us-central1"
  cluster_version = "1.29.0-gke.1381000"
  gcp_project_id  = "prod-env-888a"
  cluster_name    = "test-cluster"
  tags = {
    Name        = local.name
    Environment = local.environment
    GithubRepo  = "terraform-helm-gke-addons"
    GithubOrg   = "clouddrove"
  }
}