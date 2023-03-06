resource "aws_route53_zone" "prod" {
  name = "nuvei.com"

  tags = {
    Environment = "production"
  }
}

resource "aws_route53_record" "dev-ns" {
  zone_id = aws_route53_zone.prod.zone_id
  name    = "dev.example.com"
  type    = "CNAME"
  ttl     = "30"
  records = aws_route53_zone.prod.name_servers
}

# Create public route table and associate with public subnets
resource "aws_route_table" "public" {
  vpc_id = module.vpc.vpc_id
  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id = data.aws_subnets.public.id
  route_table_id = aws_route_table.public.id
}

# Create private route table and associate with private subnets
resource "aws_route_table" "private" {
  vpc_id = module.vpc.vpc_id
  tags = {
    Name = "private-route-table"
  }
}

resource "aws_route_table_association" "private" {
  subnet_id = data.aws_subnets.private.id
  route_table_id = aws_route_table.private.id
}