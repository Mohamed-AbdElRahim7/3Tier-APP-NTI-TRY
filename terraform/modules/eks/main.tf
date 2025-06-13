module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "19.15.3"

  cluster_name    = var.cluster_name
  cluster_version = "1.27"
  private_subnet_ids = var.private_subnet_ids
  vpc_id          = var.vpc_id

  eks_managed_node_groups = {
    default = {
      instance_types = [var.node_instance_type]
      desired_size   = var.desired_capacity
      max_size       = var.max_size
      min_size       = var.min_size
      name           = "default-node-group"
    }
  }

  tags = {
    Environment = "dev"
    Project     = var.project_name
  }
}
