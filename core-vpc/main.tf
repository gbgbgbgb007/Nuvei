resource "aws_eip" "nat" {
  count = 2

  vpc = true
}
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "core-vpc"
  cidr = "172.28.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["172.28.1.0/24", "172.28.2.0/24"]
  public_subnets  = ["172.28.101.0/24", "172.28.102.0/24"]
  database_subnets = ["172.28.121.0/24", "172.28.122.0/24"]
  elasticache_subnets = ["172.28.131.0/24", "172.28.132.0/24"]

  create_database_subnet_group = true
  enable_nat_gateway = true
  single_nat_gateway  = false
  one_nat_gateway_per_az = false
  reuse_nat_ips       = true                    # <= Skip creation of EIPs for the NAT Gateways
  external_nat_ip_ids = "${aws_eip.nat.*.id}"   # <= IPs specified here as input to the module

  tags = {
    Terraform = "true"
    Environment = "production"
  }

  enable_dns_hostnames = true
  enable_dns_support   = true
  enable_flow_log      = true
  enable_dhcp_options  = true
  dhcp_options_domain_name  = aws_route53_zone.prod.name
  flow_log_destination_type = "s3"
}

module "vpc_endpoints" {
  source = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"

  vpc_id             = module.vpc.vpc_id
  security_group_ids = [data.aws_security_group.default.id]

  endpoints = {
    s3 = {
      service = "s3"
      tags    = { Name = "s3-vpc-endpoint" }
    },
  }
}
#LOLL