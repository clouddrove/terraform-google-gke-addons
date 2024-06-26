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
          - "critical"
          
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

#---------------------------- EXTERNAL DNS ---------------------------------
resource "local_file" "external_dns_helm_config" {
  count    = var.external_dns && (var.external_dns_helm_config == null) ? 1 : 0
  content  = <<EOT

nameOverride: external-dns-gcp

sources:
  - service
  - ingress

provider: google

google:
  project: "${var.project_id}"
  serviceAccountSecret: "external-dns"
  zoneVisibility: "public"

domainFilters: ["external-dns-test.gcp.zalan.do"]

registry: "txt"
txtOwnerId: "k8s"

affinity:
  nodeAffinity:
    requiredDuringSchedulingIgnoredDuringExecution:
      nodeSelectorTerms:
      - matchExpressions:
        - key: "cloud.google.com/gke-nodepool"
          operator: In
          values:
          - "critical"
  EOT
  filename = "${path.module}/override_values/external_dns.yaml"
}

#----------------------- KUBECLARITY ------------------------------
resource "local_file" "kubeclarity_helm_config" {
  count    = var.kubeclarity && (var.kubeclarity_helm_config == null) ? 1 : 0
  content  = <<EOT
## Using limits and requests
kubeclarity:
  resources:
    limits:
      memory: "500Mi"
      cpu: "200m"
    requests:
      memory: "200Mi"
      cpu: "100m"

  podAnnotations:
    co.elastic.logs/enabled: "true"


# Be careful when using ingress. As there is no authentication on Kubeclarity yet, your instance may be accessible.
# Make sure the ingress remains internal if you decide to enable it.
  service:
    type: LoadBalancer
    port: 80
    annotations: {}
      # service.beta.kubernetes.io/aws-load-balancer-scheme: "internet-facing"
      # service.beta.kubernetes.io/aws-load-balancer-name: "kubeclarity"

  EOT
  filename = "${path.module}/override_values/kubeclarity.yaml"
}

#-------------------------- FILEBEAT --------------------------------------
resource "local_file" "filebeat_helm_config" {
  count    = var.filebeat && (var.filebeat_helm_config == null) ? 1 : 0
  content  = <<EOT

daemonset:
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
      cpu: "300m"
      memory: "200Mi"
    requests:
      cpu: 100m
      memory: 100Mi

deployment:
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
      cpu: "300m"
      memory: "200Mi"
    requests:
      cpu: 100m
      memory: 100Mi

  EOT
  filename = "${path.module}/override_values/filebeat.yaml"
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
          - "critical"
          
## Using limits and requests
resourc_helm_configes:
  limits:
    cpu: "100m"
    memory: "512Mi"
  requests:
    cpu: "10m"
    memory: "128Mi"
  EOT
  filename = "${path.module}/override_values/externalsecret.yaml"
}

#-----------ACTIONS-RUNNER-CONTROLLER--------------------
resource "local_file" "actions_runner_controller_helm_config" {
  count    = var.actions_runner_controller && (var.actions_runner_controller_helm_config == null) ? 1 : 0
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

  EOT
  filename = "${path.module}/override_values/actions_runner_controller.yaml"
}

#---------------------------- REDIS -----------------------------------------
resource "local_file" "redis_helm_config" {
  count    = var.redis && (var.redis_helm_config == null) ? 1 : 0
  content  = <<EOT

global:
  storageClass: ""
  redis:
    password: "redisPassword"

# -- master configuration parameters
master:
  count: 1
  persistence:
    size: 4Gi    
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: "cloud.google.com/gke-nodepool"
            operator: In
            values:
            - "critical"    

# -- replicas configuration parameters
replica:
  replicaCount: 2
  persistence:
    size: 4Gi
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: "cloud.google.com/gke-nodepool"
            operator: In
            values:
            - "critical"     
  EOT
  filename = "${path.module}/override_vales/redis.yaml"
}

#------------------------- PROMETHEUS -------------------------------
resource "local_file" "prometheus_helm_config" {
  count    = var.prometheus && (var.prometheus_helm_config == null) ? 1 : 0
  content  = <<EOT
server:
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: "cloud.google.com/gke-nodepool"
            operator: In
            values:
            - "critical"  

  persistentVolume:
    storageClass: standard-rwo
  EOT
  filename = "${path.module}/override_vales/prometheus.yaml"
}

#------------------------------- Grafana ------------------------------------
resource "local_file" "grafana_helm_config" {
  count    = var.grafana && (var.grafana_helm_config == null) ? 1 : 0
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
    cpu: 300m
    memory: 250Mi
  requests:
    cpu: 50m
    memory: 150Mi
  EOT
  filename = "${path.module}/override_vales/grafana.yaml"
}
