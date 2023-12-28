data "gcp_region" "current" {}

data "gcp_gke_cluster" "gke_cluster" {
  # this makes downstream resources wait for data plane to be ready
  name = var.gcp_cluster_name
}