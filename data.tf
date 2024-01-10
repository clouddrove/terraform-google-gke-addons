data "google_compute_regions" "available" {}

data "google_container_cluster" "my_cluster" {
  name     = var.gke_cluster_name
  location = "us-central1"
}