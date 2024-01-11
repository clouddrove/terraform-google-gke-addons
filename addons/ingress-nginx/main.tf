module "helm_addon" {
  source      = "../helm"
  helm_config = local.helm_config
  project_id  = var.project_id
  environment = var.environment
  addon_context = var.addon_context

  set_values = [
    {
      name  = "gcpRegion"
      value = "us-central1"
    },
    {
      name  = "autoDiscovery.clusterName"
      value = var.gke_cluster_name
    },
    {
      name  = "rbac.serviceAccount.create"
      value = "false"
    },
    {
      name  = "rbac.serviceAccount.name"
      value = "${local.name}-sa"
    }
  ]

}