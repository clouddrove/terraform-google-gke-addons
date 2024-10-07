module "helm_addon" {
  source      = "../helm"
  helm_config = local.helm_config
  set_values = [
    {
      name  = "serviceAccount.create"
      value = "true"
    },
    {
      name  = "serviceAccount.name"
      value = "${local.name}-sa"
    },
    {
      name  = "serviceAccount.automountServiceAccountToken"
      value = "true"
    },
    {
      name  = "enable_service_monitor"
      value = "false"
    },

  ]
  # -- workload identity Configurations
  workload_identity_config = {
    project_id   = var.project_id
    GCP_GSA_NAME = "${local.name}-sa"
    GCP_KSA_NAME = "${local.name}-sa"
    namespace    = local.default_helm_config.namespace
  }
}

resource "google_project_iam_member" "secretadmin" {
  project = var.project_id
  for_each = toset([
    "roles/secretmanager.admin",
    "roles/iam.serviceAccountTokenCreator"
  ])
  role   = each.key
  member = "serviceAccount:${local.name}-sa@${var.project_id}.iam.gserviceaccount.com"
}
