#----------------------------- CLUSTER AUTOSCALER ----------------------------
resource "local_file" "cluster_autoscaler_helm_config" {
  count    = var.cluster_autoscaler && (var.cluster_autoscaler_helm_config == null) ? 1 : 0
  content  = <<EOT
## Node affinity for particular node in which labels key is "Infra-Services" and value is "true"

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

additionalLabels: {}
affinity: {}
autoDiscovery:
  clusterName: ${data.google_container_cluster.my_cluster.name}
  labels: []
  roles:
  - worker
  tags:
  - k8s.io/cluster-autoscaler/enabled
  - k8s.io/cluster-autoscaler/{{ .Values.autoDiscovery.clusterName }}

cloudProvider: gce

extraArgs:
  leader-elect: false

  EOT
  filename = "${path.module}/override_values/cluster_autoscaler.yaml"
}

#---------------------------------------- Reloader -------------------------------------
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
  filename = "${path.module}/override_values/reloader.yaml"
}

#-------------INGRESS NGINX-------------------
resource "local_file" "ingress_nginx_helm_config" {
  count    = var.ingress_nginx && (var.ingress_nginx_helm_config == null) ? 1 : 0
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


## Using limits and requests

resources:
  limits:
    cpu: 150m
    memory: 150Mi
  requests:
    cpu: 100m
    memory: 90Mi

podAnnotations:
  co.elastic.logs/enabled: "true"
  
  EOT
  filename = "${path.module}/override_values/ingress_nginx.yaml"
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

#-------------------------- KEDA ----------------------------------
resource "local_file" "keda_helm_config" {
  count    = var.keda && (var.keda_helm_config == null) ? 1 : 0
  content  = <<EOT
affinity:
  nodeAffinity:
    requiredDuringSchedulingIgnoredDuringExecution:
      nodeSelectorTerms:
      - matchExpressions:
        - key: "cloud.google.com/gke-nodepool"
          operator: In
          values:
          - "general-1"
          
## Using limits and requests
resourc_helm_configes:
  limits:
    cpu: 100m
    memory: 512Mi
  requests:
    cpu: 10m
    memory: 128Mi
  EOT
  filename = "${path.module}/override_values/keda.yaml"
}

#------------------------- EXTERNAL SECRETS -----------------------------
resource "local_file" "external_secrets_helm_config" {
  count    = var.external_secrets && (var.external_secrets_helm_config == null) ? 1 : 0
  content  = <<EOT
affinity:
  nodeAffinity:
    requiredDuringSchedulingIgnoredDuringExecution:
      nodeSelectorTerms:
      - matchExpressions:
        - key: "cloud.google.com/gke-nodepool"
          operator: In
          values:
          - "general-1"
          
## Using limits and requests
resourc_helm_configes:
  limits:
    cpu: 100m
    memory: 512Mi
  requests:
    cpu: 10m
    memory: 128Mi
  EOT
  filename = "${path.module}/override_values/externalsecret.yaml"
}