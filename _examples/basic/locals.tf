locals {
  name            = "helm-addons"
  environment     = "test"
  region          = "us-central1"
  cluster_version = "1.28.3-gke.1203001"
  gcp_project_id  = "dev-env-3b53"
  cluster_name    = "helm-addons"
  tags = {
    Name        = local.name
    Environment = local.environment
    GithubRepo  = "terraform-helm-eks-addons"
    GithubOrg   = "clouddrove"
  }
}