

provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.eks_cluster.token
  }
}

# provider "kubectl" {
#   host                   = module.eks.cluster_endpoint
#   cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
#   token                  = data.aws_eks_cluster_auth.eks_cluster.token
# }
provider "kubernetes" {
  host                   = "https://${module.gke-dev.endpoint}"
  cluster_ca_certificate = base64decode(module.gke-dev.ca_certificate)
}

# provider "google" {
#   project = local.project_id
#   region  = "us-central1"
# }

provider "google-beta" {
  project = local.project_id
  region  = "us-central1"
}

