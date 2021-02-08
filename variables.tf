variable "route53_zone_name" {}
variable "domain_name" {}
variable "aws_region" {}

variable "s3_lifecycle_rules" {
  default = []
}

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

variable "forward_query_string" {
  type = bool
  default = true
}
