data "aws_route53_zone" "zone" {
  name = "${var.route53_zone_name}"
}

module "certificate" {
  source = "github.com/jetbrains-infra/terraform-aws-acm-certificate?ref=v0.1.1"

  hostnames = [
    "${var.domain_name}",
  ]

  zone_ids = [
    "${data.aws_route53_zone.zone.id}",
  ]

  region = "us-east-1"
}
