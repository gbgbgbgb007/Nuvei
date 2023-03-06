data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.current.id]
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.current.id]
  }
}

data "aws_security_group" "elb" {
  name   = "elb-security-group"
  vpc_id = data.aws_vpc.current.id
}

data "aws_vpc" "current" {
  tags = {
    Name   = "core-vpc"
  }
}


data "aws_region" "current" {
  
}
