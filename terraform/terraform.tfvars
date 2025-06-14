############################################
# terraform.tfvars - actual input values
############################################

project_name = "nti-3tier-app"
region       = "us-east-1"
account_id   = "757351641388"

vpc_cidr             = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.101.0/24", "10.0.102.0/24"]
availability_zones   = ["us-east-1a", "us-east-1b"]
eks_nodes_cidr       = "10.0.0.0/16"

cluster_name       = "nti-3Tier-App"
node_instance_type = "t3.medium"
desired_capacity   = 2
max_size           = 4
min_size           = 1

db_name              = "ntiapp"
db_instance_class    = "db.t3.micro"
db_allocated_storage = 20

ami_id                = "ami-0c02fb55956c7d316"
jenkins_instance_type = "t3.medium"
key_name              = "jenkins"

elb_logs_bucket_name = "nti-elb-logs-bucket-abdelrahim"
