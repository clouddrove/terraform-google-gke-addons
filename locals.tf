locals {
  addon_context = {
    gcp_region_name = data.google_client_config.current.region
    gke_cluster_id  = data.google_container_cluster.my_cluster.name
    tags            = var.tags
  }
}