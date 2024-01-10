locals {
  addon_context = {
    gcp_region_name = "us-central1"
    gke_cluster_id  = data.google_container_cluster.my_cluster.name
    tags            = var.tags
  }
}