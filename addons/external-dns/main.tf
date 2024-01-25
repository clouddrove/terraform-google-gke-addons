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
      name  = "google.serviceAccountSecret"
      value = "${kubernetes_secret.external_dns_secret.metadata[0].name}"
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

resource "google_project_iam_member" "member-role" {
  for_each = toset([
    "roles/dns.admin",
    "roles/iam.serviceAccountTokenCreator"
  ])
  role    = each.key
  member  = "serviceAccount:${local.name}-sa@${var.project_id}.iam.gserviceaccount.com"
  project = var.project_id
}

resource "google_service_account_key" "external_dns_key" {
  service_account_id = "${local.name}-sa"
}

resource "kubernetes_secret" "external_dns_secret" {
  metadata {
    name      = local.name
    namespace = local.default_helm_config.namespace
  }

  data = {
    "credentials.json" = base64decode(google_service_account_key.external_dns_key.private_key)
  }
}

