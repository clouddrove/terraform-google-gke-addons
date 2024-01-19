resource "google_service_account" "gke" {
  project      = var.project_id
  account_id   = format("%s", var.GCP_GSA_NAME)
  display_name = "Service Account for Keda Scaler"
}

resource "google_service_account_iam_member" "pod_identity" {
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${var.project_id}.svc.id.goog[${var.namespace}/${var.GCP_KSA_NAME}]"
  service_account_id = google_service_account.gke.name
}