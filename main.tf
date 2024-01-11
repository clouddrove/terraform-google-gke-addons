module "cluster_autoscaler" {
  source           = "./addons/cluster-autoscaler"
  count            = var.cluster_autoscaler ? 1 : 0
  environment      = var.environment
  project_id       = var.project_id
  gke_cluster_name = data.google_container_cluster.my_cluster.name
  addon_context    = local.addon_context
}

module "reloader" {
  source           = "./addons/reloader"
  count            = var.reloader ? 1 : 0
  environment      = var.environment
  project_id       = var.project_id
  gke_cluster_name = data.google_container_cluster.my_cluster.name
  addon_context    = local.addon_context
}

module "ingress-nginx" {
  source           = "./addons/ingress-nginx"
  count            = var.ingress-nginx ? 1 : 0
  environment      = var.environment
  project_id       = var.project_id
  gke_cluster_name = data.google_container_cluster.my_cluster.name
  addon_context    = local.addon_context
}

