resource "kubernetes_namespace_v1" "irsa" {
  count = var.create_kubernetes_namespace && var.kubernetes_namespace != "kube-system" ? 1 : 0
  metadata {
    name = var.kubernetes_namespace
  }

  timeouts {
    delete = "15m"
  }
}

resource "kubernetes_service_account_v1" "irsa" {
  count = var.create_kubernetes_service_account ? 1 : 0
  metadata {
    name        = var.kubernetes_service_account
    namespace   = try(kubernetes_namespace_v1.irsa[0].metadata[0].name, var.kubernetes_namespace)
    annotations = var.irsa_iam_policies != null ? { "iam.gke.io/gcp-service-account" : google_service_account.service_account.email } : null
  }

  dynamic "image_pull_secret" {
    for_each = var.kubernetes_svc_image_pull_secrets != null ? var.kubernetes_svc_image_pull_secrets : []
    content {
      name = image_pull_secret.value
    }
  }

  automount_service_account_token = true
}

resource "google_service_account" "service_account" {
  account_id   = var.account_id
  display_name = var.kubernetes_service_account
}

resource "google_project_iam_binding" "example_binding" {
  service_account_id = "${google_service_account.service_account.email}"
  project            = var.project_id
  role               = "roles/iam.workloadIdentityUser"
  

  members = [
    "serviceAccount:your-project-id.svc.id.goog[${var.kubernetes_namespace}/${var.kubernetes_service_account}]",
  ]
}
