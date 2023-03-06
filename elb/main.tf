module "elb" {
  source = "terraform-aws-modules/elb/aws"

  name = "nuvei-elb"
  subnets = [data.aws_subnets.private.id, data.aws_subnets.public.id]
  security_groups = [data.aws_security_group.elb.id]

  listener = [
    {
      instance_port = 80
      instance_protocol = "http"
      lb_port = 80
      lb_protocol = "http"
    },
    {
      instance_port = 443
      instance_protocol = "https"
      lb_port = 443
      lb_protocol = "https"
      ssl_certificate_id = "${var.ssl_certificate_id}"
    },
  ]

  health_check = {
    target = "HTTP:80/"
    interval = 30
    timeout = 5
    healthy_threshold = 2
    unhealthy_threshold = 2
  }

  tags = {
    Terraform   = "true"
    Environment = "production"
  }

  //route53_zone_name = "${var.route53_zone_name}"
  //route53_record_name = "${var.route53_record_name}"
}