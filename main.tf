# ------------------------------------------------------------------------------
# Modules
# ------------------------------------------------------------------------------
module "cluster_autoscaler" {
  count                            = var.cluster_autoscaler ? 1 : 0
  source                           = "./addons/cluster-autoscaler"
  helm_config                      = var.cluster_autoscaler_helm_config != null ? var.cluster_autoscaler_helm_config : { values = [local_file.cluster_autoscaler_helm_config[count.index].content] }
  manage_via_gitops                = var.manage_via_gitops
  addon_context                    = local.addon_context
  gke_cluster_name                 = data.gcp_gke_cluster.gke_cluster.name
  account_id                       = data.gcp_caller_identity.current.account_id
  project_id                       = data.gcp_caller_identity.current.project_id
  # cluster_autoscaler_extra_configs = var.cluster_autoscaler_extra_configs
}