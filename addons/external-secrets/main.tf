module "helm_addon" {
  source      = "../helm"
  helm_config = local.helm_config
  set_values = [
    {
      name  = "templatefile"
      value = "${path.module}/config/values.yaml"
    },
    {
      name  = "enable_service_monitor"
      value = "false"
    },
    {
      name  = "service_account_email"
      value = google_service_account.external_secrets.email
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

resource "google_service_account" "external_secrets" {
  project      = var.project_id
  account_id   = format("%s-%s-%s", var.environment, var.GCP_GSA_NAME, var.name)
  display_name = "Service Account for External Secrets"
}

resource "google_project_iam_member" "secretadmin" {
  project = var.project_id
  role    = "roles/secretmanager.admin"
  member  = "serviceAccount:${google_service_account.external_secrets.email}"
}

resource "google_project_iam_member" "service_account_token_creator" {
  project = var.project_id
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:${google_service_account.external_secrets.email}"
}

resource "google_service_account_iam_member" "pod_identity" {
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${var.project_id}.svc.id.goog[secrets/${var.GCP_KSA_NAME}]"
  service_account_id = google_service_account.external_secrets.name
}

