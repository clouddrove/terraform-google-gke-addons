module "helm_addon" {
  source = "../helm"

  manage_via_gitops = var.manage_via_gitops
  helm_config       = local.helm_config
  addon_context     = var.addon_context

  set_values = [
    {
      name  = "gcp_region"
      value = data.gcp_region.current.name
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

  # -- IRSA Configurations
  irsa_config = {
    irsa_iam_policies                 = ["roles/storage.admin", "roles/pubsub.publisher"]
    create_kubernetes_service_account = true
    kubernetes_service_account        = "${local.name}-sa"
    kubernetes_namespace              = local.default_helm_config.namespace
    account_id                        = var.account_id
    project_id                        = var.account_id
  }

}

#  resource "google_project_iam_member" "policy" {
#   role   = "roles/owner"
#   member = "serviceAccount:${google_service_account.service_account.email}"
#   project = "your-gcp-project-id"
# }


