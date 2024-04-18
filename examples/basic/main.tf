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
  name                              = "${local.name}-cluster"
  region                            = local.region
  kubernetes_version                = local.cluster_version
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
      node_locations               = "${local.region}-c"
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
      enable_node_pool_autoscaling = true
    },
    {
      name                         = "critical"
      machine_type                 = "g1-small"
      node_locations               = "${local.region}-c"
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
      enable_node_pool_autoscaling = true
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
    all = [
      local.tags.Name,
      local.tags.Environment,
      local.tags.GithubRepo,
      local.tags.GithubOrg,
    ]
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

  depends_on       = [module.gke]
  gke_cluster_name = module.gke.name
  project_id       = local.gcp_project_id
  region           = local.region

  cluster_autoscaler        = true
  reloader                  = true
  ingress_nginx             = true
  certification_manager     = true
  keda                      = true
  kubeclarity               = true
  external_dns              = true
  external_secrets          = true
  actions_runner_controller = true
  redis                     = true
  prometheus                = true
}
