module "Network" {
  source         = "./modules/Network"
  VPC_CIDR       = var.VPC_CIDR
  PUBLIC_SUBNETS = var.PUBLIC_SUBNETS
}

module "eks" {
  depends_on = [module.Network]
  source     = "terraform-aws-modules/eks/aws"
  version    = "20.24.3"

  cluster_name    = "SK_eks_cluster"
  cluster_version = "1.29"

  cluster_endpoint_public_access = true

  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
    aws-ebs-csi-driver     = {}
  }

  vpc_id                   = module.Network.VPC_ID
  subnet_ids               = module.Network.Subnet_IDs
  control_plane_subnet_ids = module.Network.control_Subnet_IDs

  cluster_service_ipv4_cidr = "10.193.100.0/24"

  eks_managed_node_group_defaults = {
    instance_types = ["t3.medium"]
  }

  eks_managed_node_groups = {
    worker_node = {
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t3.medium"]

      min_size     = 1
      max_size     = 3
      desired_size = 3

      iam_role_additional_policies = { AmazonEBSCSIDriverPolicy = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy" }
    }
  }

  enable_cluster_creator_admin_permissions = true

  access_entries = {
    test1 = {
      kubernetes_groups = []
      principal_arn     = "arn:aws:iam::111111111111:role/role-eks" # set your role

      policy_associations = {
        test2 = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSViewPolicy"
          access_scope = {
            namespaces = ["default"]
            type       = "namespace"
          }
        }
      }
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
