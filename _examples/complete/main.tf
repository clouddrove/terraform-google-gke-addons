###############################################################################
# Resources
###############################################################################


locals {
  network_name         = "dev-vpc"
  region               = "us-west1"
  secondary-range-name = "test-seconadry-range"
}


module "dev-vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 8.0"

  project_id   = var.dev_project_id
  network_name = local.network_name
  routing_mode = "GLOBAL"

  subnets = [
    {
      subnet_name               = "${local.network_name}-subnet-private-1"
      subnet_ip                 = "10.20.0.0/24"
      subnet_region             = local.region
      subnet_private_access     = true
      subnet_flow_logs          = true
      subnet_flow_logs_sampling = "0.5"
      subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
      subnet_flow_logs_interval = "INTERVAL_10_MIN"
    },
    {
      subnet_name               = "${local.network_name}-subnet-public-1"
      subnet_ip                 = "10.20.1.0/24"
      subnet_region             = local.region
      subnet_private_access     = false
      subnet_flow_logs          = true
      subnet_flow_logs_sampling = "0.5"
      subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
      subnet_flow_logs_interval = "INTERVAL_10_MIN"
    },
  ]

  secondary_ranges = {
    ("dev-vpc-subnet-private-1") = [
      {
        range_name    = local.secondary-range-name
        ip_cidr_range = "10.52.0.0/14"
      },
      {
        range_name    = local.secondary-range-name
        ip_cidr_range = "10.56.0.0/20"
      },
    ]
  }

  firewall_rules = [
    {
      name      = "test-allow-all"
      direction = "INGRESS"
      priority  = 10000

      log_config = {
        metadata = "INCLUDE_ALL_METADATA"
      }

      allow = [{
        protocol = "tcp"
        ports    = ["1-65535"]
        }
      ]
      ranges = [
        "10.20.0.0/24", "10.20.1.0/24", "10.10.0.0/24", "10.10.1.0/24"
      ]
    },
  ]
}

###############################################################################
# GCP GKE
###############################################################################

module "gke-test" {
  source                            = "terraform-google-modules/kubernetes-engine/google//modules/beta-private-cluster"
  version                           = "29.0.0"
  project_id                        = var.project_id
  name                              = var.cluster_name_suffix
  region                            = var.region
  zones                             = var.zones
  network                           = var.network
  subnetwork                        = var.subnetwork
  ip_range_pods                     = var.ip_range_pods
  ip_range_services                 = var.ip_range_services
  create_service_account            = true
  remove_default_node_pool          = true
  disable_legacy_metadata_endpoints = false
  deletion_protection               = false

  node_pools = [

    {
      name                         = "general-1"
      machine_type                 = var.machine_type_general-1
      node_locations               = var.node_locations
      min_count                    = 1
      max_count                    = 5
      local_ssd_count              = 0
      spot                         = false
      disk_size_gb                 = var.disk_size_gb_general-1
      disk_type                    = var.disk_type_general-1
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
      name                         = "general-2"
      machine_type                 = var.machine_type_general-2
      node_locations               = var.node_locations
      min_count                    = 1
      max_count                    = 3
      local_ssd_count              = 0
      spot                         = false
      disk_size_gb                 = var.disk_size_gb_general-2
      disk_type                    = var.disk_type_general-2
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

  depends_on       = [module.gke_test]
  gke_cluster_name = module.gke_test.name

  # -- Enable Addons
  metrics_server             = true
  ingress_nginx              = true
  certification_manager      = true
  horizontal_pod_autoscaling = true
  http_load_balancing        = true
  filestore_csi_driver       = true
  istio                      = true
  dns_cache                  = false

}
