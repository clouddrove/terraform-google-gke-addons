data "google_client_config" "current" {}
# data "gcp_partition" "current" {}
# data "gcp_caller_identity" "current" {}
data "gcp_region" "current" {}
data "gcp_gke_cluster" "gke_cluster" {
  name = var.gke_cluster_name
}

resource "time_sleep" "dataplane" {
  create_duration = "10s"

  triggers = {
    data_plane_wait_arn = var.data_plane_wait_arn                      # Replace with your GCP-specific wait ARN
    gke_cluster_id      = data.google_container_cluster.gke_cluster.id # GKE cluster ID for downstream resources
  }
}