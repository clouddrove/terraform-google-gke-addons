#----------------------------- CLUSTER AUTOSCALER ----------------------------
resource "local_file" "cluster_autoscaler_helm_config" {
  count    = var.cluster_autoscaler && (var.cluster_autoscaler_helm_config == null) ? 1 : 0
  content  = <<EOT
## Node affinity for particular node in which labels key is "Infra-Services" and value is "true"

affinity:
  nodeAffinity:
    requiredDuringSchedulingIgnoredDuringExecution:
      nodeSelectorTerms:
      - matchExpressions:
        - key: "cloud.google.com/gke-nodepool"
          operator: In
          values:
          - "critical"


## Using limits and requests
resourc_helm_configes:
  limits:
    cpu: 300m
    memory: 250Mi
  requests:
    cpu: 50m
    memory: 150Mi

podAnnotations:
  co.elastic.logs/enabled: "true"

  EOT
  filename = "${path.module}/override_values/cluster_autoscaler.yaml"
}

#---------------------- RELOADER --------------------------

resource "local_file" "reloader_helm_config" {
  count    = var.reloader && (var.reloader_helm_config == null) ? 1 : 0
  content  = <<EOT

reloader:
  deployment:
    # If you wish to run multiple replicas set reloader.enableHA = true
    affinity:
      nodeAffinity:
        requiredDuringSchedulingIgnoredDuringExecution:
          nodeSelectorTerms:
          - matchExpressions:
            - key: "cloud.google.com/gke-nodepool"
              operator: In
              values:
              - "critical"

    resources:
      limits:
        cpu: "100m"
        memory: "512Mi"
      requests:
        cpu: "10m"
        memory: "128Mi"
  EOT
  filename = "${path.module}/override_vales/reloader.yaml"
}

#---------------------- CERTIFICATION-MANAGER --------------------------
resource "local_file" "certification_manager_helm_config" {
  count    = var.certification_manager && (var.certification_manager_helm_config == null) ? 1 : 0
  content  = <<EOT

affinity:
  nodeAffinity:
    requiredDuringSchedulingIgnoredDuringExecution:
      nodeSelectorTerms:
      - matchExpressions:
        - key: "cloud.google.com/gke-nodepool"
          operator: In
          values:
          - "critical"

resources:
  limits:
    cpu: 200m
    memory: 250Mi
  requests:
    cpu: 50m
    memory: 150Mi

installCRDs: true

  EOT
  filename = "${path.module}/override_values/certification_manager.yaml"
}
