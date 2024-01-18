module "helm_addon" {
  source        = "../helm"
  helm_config   = local.helm_config
  project_id    = var.project_id
  environment   = var.environment
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
      value = "true"
    },
    {
      name  = "rbac.serviceAccount.name"
      value = "${local.name}-sa"
    },
    {
      name  = "cloudProvider"
      value = "gce"
    }
  ]

  # -- workload identity Configurations
  workload_identity_config = {
    environment  = var.environment
    project_id   = var.project_id
    GCP_GSA_NAME = "${local.name}-sa"
    GCP_KSA_NAME = "${local.name}-sa"
    namespace    = local.default_helm_config.namespace
  }
}

resource "google_project_iam_member" "member-role" {
  for_each = toset([
    "roles/compute.instanceAdmin.v1",
    "roles/iam.serviceAccountTokenCreator"
  ])
  role    = each.key
  member  = "serviceAccount:${var.environment}-${local.name}-sa@${var.project_id}.iam.gserviceaccount.com"
  project = var.project_id
}

