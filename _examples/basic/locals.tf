locals {
  name            = "helm-addons"
  environment     = "test"
  region          = "us-central1"
  cluster_version = "latest"
  gcp_project_id  = "dev-env-3b53"
  cluster_name    = "${local.name}-cluster"
  tags = {
    Name        = local.name
    Environment = local.environment
    GithubRepo  = "terraform-helm-gke-addons"
    GithubOrg   = "clouddrove"
  }
}