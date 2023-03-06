variable "ssl_certificate_id" {
  type = string
}

variable "route53_zone_name" {
  type = string

}

variable "route53_record_name" {
  type = string
  default = "nuvei-elb"
}
