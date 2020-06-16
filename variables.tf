variable "route53_zone_name" {}
variable "domain_name" {}
variable "aws_region" {}

variable "waf_id" {
  default = ""
}

variable "website_name" {}
variable "lambda_associations" {
  type = list(map(string))
  default = []
}

variable "use_s3_origin_identity" {
  type = bool
  default = false
}

variable "register_ipv6" {
  type = bool
  default = false
}
