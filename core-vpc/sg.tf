# Create security group to allow port 80 and 443 from the internet
resource "aws_security_group" "elb" {
  name = "elb-security-group"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "elb-security-group"
  }
}


/*resource "aws_security_group" "example" {
  name_prefix = "example-elb-security-group"
  description = "Example security group for web server"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "example-security-group"
  }
}
*/
/*module "elb_security_group" {
  source = "terraform-aws-modules/security-group/aws"

  name = "example-elb-security-group"
  vpc_id = data.aws_vpc.current.id//"${module.vpc}"

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules            = ["https-80-tcp"]
  ingress_with_cidr_blocks = [
    {
      description      = "HTTP"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      security_groups  = []
      self             = false
      prefix_list_ids  = []
    },
    {
      description      = "HTTPS"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      security_groups  = []
      self             = false
      prefix_list_ids  = []
    },
  ]

  tags = {
    Terraform   = "true"
    Environment = "production"
  }
}
*/