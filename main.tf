# Specify the AWS provider
provider "aws" {
  region = "us-east-1" # Set the AWS region
}

# Call the VPC module
module "vpc" {
  source             = "./modules/vpc"                # Path to the VPC module
  cidr_block         = "10.0.0.0/16"                  # CIDR block for the VPC
  subnet_cidrs       = ["10.0.1.0/24", "10.0.2.0/24"] # Subnets' CIDR blocks
  availability_zones = ["us-east-1a", "us-east-1b"]   # Availability zones for subnets
  name               = "my-vpc"                       # Name of the VPC
}

# Call the ECS Cluster module
module "ecs_cluster" {
  source        = "./modules/ecs-cluster" # Path to the ECS Cluster module
  cluster_name  = "my-ecs-cluster"        # Name of the ECS cluster
  environment   = "dev"                   # Environment tag
}

# Call the ECS Service module
module "ecs_service" {
  source                = "./modules/ecs-service"        # Path to the ECS Service module
  task_family           = "my-task-family"              # Task family name
  container_definitions = [{
    name         = "nginx"                              # Name of the container
    image        = "nginx:latest"                      # Docker image
    cpu          = 256                                 # CPU units
    memory       = 512                                 # Memory
    essential    = true                                # Essential container
    portMappings = [{                                  # Port mapping for container
      containerPort = 80
      hostPort      = 80
    }]
  }]
  execution_role_arn    = "arn:aws:iam::123456789012:role/my-execution-role" # IAM execution role
  memory                = "512"                           # Memory for the task
  cpu                   = "256"                           # CPU for the task
  service_name          = "my-service"                   # ECS service name
  cluster_id            = module.ecs_cluster.ecs_cluster_id # ECS cluster ID
  desired_count         = 1                              # Desired number of tasks
  subnet_ids            = module.vpc.subnet_ids          # Subnet IDs from the VPC
  security_group_ids    = ["sg-12345678"]                # Security group IDs
} # Closing the ecs_service module block properly

