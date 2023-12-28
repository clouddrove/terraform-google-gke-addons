###############################################################################
# Resources
###############################################################################


module "dev-vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 8.0"

#   project_id   = var.dev_project_id
  project_id   = local.project_id
  network_name = local.network_name
  routing_mode = "GLOBAL"

  
  subnets = [
    {
      subnet_name               = "subnet-private-1"
      subnet_ip                 = "10.20.0.0/24"
      subnet_region             = local.region
      subnet_private_access     = true
      subnet_flow_logs          = true
      subnet_flow_logs_sampling = "0.5"
      subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
      subnet_flow_logs_interval = "INTERVAL_10_MIN"
    },
    {
      subnet_name               = "subnet-public-1"
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
  ("subnet-private-1") = [
    {
      range_name    = "secondary-range-name-1"  # Unique name for the first secondary IP range
      ip_cidr_range = "10.52.0.0/14"
    },
    {
      range_name    = "secondary-range-name-2"  # Unique name for the second secondary IP range
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

module "gke-dev" {
  source                            = "terraform-google-modules/kubernetes-engine/google//modules/beta-private-cluster"
  version                           = "29.0.0"
  project_id                        = local.project_id
  name                              = local.cluster_name 
  region                            = local.region 
  zones                             = []
  network                           = local.network_name
  subnetwork                        = "subnet-private-1"
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
      name                         = "general-1"
      machine_type                 = "g1-small"
      node_locations               = "us-west1-a"
      min_count                    = 1
      max_count                    = 5
      local_ssd_count              = 0
      spot                         = false
      disk_size_gb                 = 8
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
      name                         = "general-2"
      machine_type                 = "g1-small"
      node_locations               = "us-west1-a"
      min_count                    = 1
      max_count                    = 3
      local_ssd_count              = 0
      spot                         = false
      disk_size_gb                 = 8
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


# module "addons" {
#   source = "../../"

#   depends_on       = [module.gke_test]
#   gke_cluster_name = module.gke_test.name

#   # -- Enable Addons
#   metrics_server             = true
#   ingress_nginx              = true
#   certification_manager      = true
#   istio                      = true
#   dns_cache                  = false
#   kalm_config                = false

# }
