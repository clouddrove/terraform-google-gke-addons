locals {

  addon_context = {
    # aws_caller_identity_account_id = data.aws_caller_identity.current.account_id
    # aws_caller_identity_arn        = data.aws_caller_identity.current.arn
    gcp_region_name          = data.aws_region.current.name
    gke_cluster_id           = data.aws_eks_cluster.eks_cluster.id
    gcp_gke_cluster_endpoint = data.aws_eks_cluster.eks_cluster.endpoint
    # eks_oidc_issuer_url            = data.aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
    # eks_oidc_provider_arn          = replace(data.aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer, "https://", "")
    # aws_partition_id               = data.aws_partition.current.partition
    # irsa_iam_role_path             = var.irsa_iam_role_path
    # irsa_iam_permissions_boundary  = var.irsa_iam_permissions_boundary
    # tags                           = var.tags
  }
  # network_name = "dev-vpc"
  cluster_name = "my-test-cluster"
  region       = "us-central1"
  #   secondary-range-name = "test"
  project_id = "cloud-crew-404516"
}

