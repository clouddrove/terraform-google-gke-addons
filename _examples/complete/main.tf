
provider "google" {
  project = local.gcp_project_id
}

###############################################################################
# GCP NETWORKING RESOURCES
###############################################################################


module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 8.1"

  project_id   = local.gcp_project_id
  network_name = "${local.name}-vpc"
  routing_mode = "GLOBAL"

  subnets = [
    {
      subnet_name   = "${local.name}-subnet-public-1"
      subnet_ip     = "10.10.10.0/24"
      subnet_region = "us-central1"
    },
    {
      subnet_name           = "${local.name}-subnet-private-1"
      subnet_ip             = "10.10.20.0/24"
      subnet_region         = "us-central1"
      subnet_private_access = "true"
      subnet_flow_logs      = "true"
      description           = "This subnet has a description"
    },
    {
      subnet_name           = "${local.name}-subnet-private-2"
      subnet_ip             = "10.10.30.0/24"
      subnet_region         = "us-central1"
      subnet_private_access = "true"
      subnet_flow_logs      = "true"
      description           = "This subnet has used for GKE"
    }
  ]

  secondary_ranges = {
    subnet-public-1 = [
      {
        range_name    = "${local.name}-subnet-private-1-secondary-01"
        ip_cidr_range = "192.168.64.0/24"
      },
    ],
    subnet-public-2 = [
      {
        range_name    = "${local.name}-subnet-private-2-secondary-01"
        ip_cidr_range = "192.168.128.0/24"
      },
    ]
  }

  routes = [
    {
      name              = "egress-internet"
      description       = "route through IGW to access internet"
      destination_range = "0.0.0.0/0"
      tags              = "egress-inet"
      next_hop_internet = "true"
    },
  ]
}

###############################################################################
# GCP GKE
###############################################################################

module "gke" {
  source                            = "terraform-google-modules/kubernetes-engine/google//modules/beta-private-cluster"
  version                           = "29.0.0"
  project_id                        = local.gcp_project_id
  name                              = local.cluster_name
  region                            = local.region
  zones                             = []
  network                           = module.vpc.network_name
  subnetwork                        = "${local.name}-subnet-private-2"
  ip_range_pods                     = ""
  ip_range_services                 = ""
  horizontal_pod_autoscaling        = true
  http_load_balancing               = true
  filestore_csi_driver              = true
  istio                             = true
  create_service_account            = true
  remove_default_node_pool          = true
  disable_legacy_metadata_endpoints = false
  deletion_protection               = false

  node_pools = [

    {
      name                         = "general"
      machine_type                 = "g1-small"
      node_locations               = "${local.region}-a"
      min_count                    = 1
      max_count                    = 5
      local_ssd_count              = 0
      spot                         = false
      disk_size_gb                 = 10
      disk_type                    = "pd-standard"
      image_type                   = "ubuntu_containerd"
      enable_gcfs                  = false
      enable_gvnic                 = false
      logging_variant              = "DEFAULT"
      auto_repair                  = true
      auto_upgrade                 = true
      create_service_account       = true
      preemptible                  = false
      initial_node_count           = 1
      enable_node_pool_autoscaling = true
    },
    {
      name                         = "critical"
      machine_type                 = "g1-small"
      node_locations               = "${local.region}-b"
      min_count                    = 1
      max_count                    = 3
      local_ssd_count              = 0
      spot                         = false
      disk_size_gb                 = 10
      disk_type                    = "pd-standard"
      image_type                   = "ubuntu_containerd"
      enable_gcfs                  = false
      enable_gvnic                 = false
      logging_variant              = "DEFAULT"
      auto_repair                  = true
      auto_upgrade                 = true
      create_service_account       = true
      preemptible                  = false
      initial_node_count           = 1
      enable_node_pool_autoscaling = false
    },
  ]


  node_pools_labels = {
    all = {}

    default-node-pool = {
      default-node-pool = true
    }
  }

  node_pools_metadata = {
    all = {}

    default-node-pool = {
      node-pool-metadata-custom-value = "my-node-pool"
    }
  }

  node_pools_taints = {
    all = []

    default-node-pool = [
      {
        key    = "default-node-pool"
        value  = true
        effect = "PREFER_NO_SCHEDULE"
      },
    ]
  }

  node_pools_tags = {
    all = []

    default-node-pool = [
      "default-node-pool",
    ]
  }
}


###############################################################################
# GCP ADDONS
###############################################################################

module "addons" {
  source = "../../"

  gke_cluster_name = module.gke.name
  project_id       = local.gcp_project_id
  environment      = local.environment
  region           = local.region

  cluster_autoscaler    = false
  reloader              = false
  ingress_nginx         = false
  certification_manager = false
  keda                  = true

  # -- Path of override-values.yaml file
  cluster_autoscaler_helm_config    = { values = [file("./config/override-cluster-autoscaler.yaml")] }
  reloader_helm_config              = { values = [file("./config/reloader/override-reloader.yaml")] }
  ingress_nginx_helm_config         = { values = [file("./config/override-ingress-nginx.yaml")] }
  certification_manager_helm_config = { values = [file("./config/override-certification-manager.yaml")] }
  keda_helm_config                  = { values = [file("./config/keda/override-keda.yaml")] }

  # -- Override Helm Release attributes
  cluster_autoscaler_extra_configs    = var.cluster_autoscaler_extra_configs
  reloader_extra_configs              = var.reloader_extra_configs
  ingress_nginx_extra_configs         = var.ingress_nginx_extra_configs
  certification_manager_extra_configs = var.certification_manager_extra_configs
  keda_extra_configs                  = var.keda_extra_configs
}