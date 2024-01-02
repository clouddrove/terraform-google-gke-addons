###############################################################################
# Resources
###############################################################################
provider "google" {
  project = local.project_id
  # region  = var.gcp_region
  # zone    = var.gcp_zone
}


module "vpc" {
  source = "terraform-google-modules/network/google//modules/vpc"
  # version = "1.0.0"

  network_name = "${local.name}-vpc"
  project_id   = local.gcp_project_id
}

module "subnets" {
  source = "terraform-google-modules/network/google//modules/subnets"

  project_id   = local.gcp_project_id
  network_name = module.vpc.network_id

  subnets = [
    {
      subnet_name   = "subnet-01"
      subnet_ip     = "10.10.10.0/24"
      subnet_region = "us-central1"
    },
    {
      subnet_name           = "subnet-private-1"
      subnet_ip             = "10.10.20.0/24"
      subnet_region         = "us-central1"
      subnet_private_access = "true"
      subnet_flow_logs      = "true"
      purpose               = "INTERNAL_HTTPS_LOAD_BALANCER"
      role                  = "ACTIVE"
    },
    {
      subnet_name                  = "subnet-public-1"
      subnet_ip                    = "10.10.30.0/24"
      subnet_region                = "us-central1"
      subnet_flow_logs             = "true"
      subnet_flow_logs_interval    = "INTERVAL_10_MIN"
      subnet_flow_logs_sampling    = 0.7
      subnet_flow_logs_metadata    = "INCLUDE_ALL_METADATA"
      subnet_flow_logs_filter_expr = "true"
    }
  ]

  secondary_ranges = {
    subnet-01 = [
      {
        range_name    = "subnet-01-secondary-01"
        ip_cidr_range = "192.168.64.0/24"
      },
    ]

    subnet-02 = []
  }
}

###############################################################################
# GCP GKE
###############################################################################

module "gke" {
  source = "terraform-google-modules/kubernetes-engine/google//modules/beta-private-cluster"
  # version                           = "29.0.0"
  project_id                        = local.project_id
  name                              = local.cluster_name
  region                            = local.region
  zones                             = []
  network                           = module.vpc.vpc_id
  subnetwork                        = module.subnet.id
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

#   # depends_on = [module.gke] # Define module.gke as a single-item list

#   gke_cluster_name = module.gke.name

#   # -- Enable Addons

#   # cluster_autoscaler           = false
#   ingress_nginx = true



#   # -- Path of override-values.yaml file

#   ingress_nginx_helm_config = { values = [file("./config/override-ingress-nginx.yaml")] }


#   # -- Override Helm Release attributes
#   ingress_nginx_extra_configs = var.ingress_nginx_extra_configs

# }



