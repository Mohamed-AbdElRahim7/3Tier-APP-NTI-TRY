provider "aws" {
  region = "us-east-1"
}


module "vpc" {
  source              = "./modules/vpc"
  project_name        = var.project_name
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

module "security_groups" {
  source            = "./modules/security-groups"
  project_name      = var.project_name
  vpc_id            = module.vpc.vpc_id
  eks_nodes_cidr    = var.eks_nodes_cidr
  eks_node_sg_id = module.eks.cluster_security_group_id
}

module "iam" {
  source       = "./modules/iam"
  project_name = var.project_name
}

module "secrets" {
  source        = "./modules/secrets"

  db_username = var.db_username
  db_password = var.db_password
  project_name = var.project_name
}

module "eks" {
  source              = "./modules/eks"
  cluster_name        = var.cluster_name
  vpc_id              = module.vpc.vpc_id
  private_subnet_ids  = module.vpc.private_subnet_ids
  node_instance_type  = var.node_instance_type
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  min_size            = var.min_size
  project_name        = var.project_name
  cluster_role_arn     = module.iam.eks_cluster_role_arn
  node_group_role_arn  = module.iam.eks_node_group_role_arn

}

module "rds" {
  source                = "./modules/rds"
  project_name          = var.project_name
  private_subnet_ids    = module.vpc.private_subnet_ids
  db_name               = var.db_name
  db_instance_class     = var.db_instance_class
  db_allocated_storage  = var.db_allocated_storage
  db_secret_arn         = module.secrets.secret_arn

  db_username = var.db_username
  db_password = var.db_password
  db_sg_id = module.security_groups.rds_sg_id
}

module "ec2_jenkins" {
  source             = "./modules/ec2-jenkins"
  project_name       = var.project_name
  ami_id             = var.ami_id
  instance_type      = var.jenkins_instance_type
  subnet_id          = module.vpc.public_subnet_ids[0]
  security_group_id  = module.security_groups.jenkins_sg_id
  key_name           = var.key_name
}

module "backup" {
  source               = "./modules/backup"
  project_name         = var.project_name
  jenkins_instance_arn = "arn:aws:ec2:${var.region}:${var.account_id}:instance/${module.ec2_jenkins.jenkins_instance_id}"
  backup_role_arn      = module.iam.backup_role_arn
}

module "ecr" {
  source        = "./modules/ecr"
  project_name  = var.project_name
}

module "s3" {
  source        = "./modules/s3"
  project_name  = var.project_name
  bucket_name   = var.elb_logs_bucket_name
}
