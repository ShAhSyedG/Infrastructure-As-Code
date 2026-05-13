project_name = "codecirrus"
environment  = "prod"
aws_region   = "us-east-1"

vpc_cidr           = "10.2.0.0/16"
availability_zones = ["us-east-1a", "us-east-1b"]

public_subnet_cidrs  = ["10.2.1.0/24", "10.2.2.0/24"]
private_subnet_cidrs = ["10.2.101.0/24", "10.2.102.0/24"]

enable_nat_gateway = true
single_nat_gateway = false # one NAT GW per AZ for full HA in prod

tags = {
  Owner = "platform-team"
}
