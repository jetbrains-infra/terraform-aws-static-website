data "aws_route53_zone" "zone" {
  name = var.route53_zone_name
}

module "certificate" {
  source = "github.com/jetbrains-infra/terraform-aws-acm-certificate?ref=v0.3.0"

  name = "site-${local.domain_name}"

  aliases = [
    {
      hostname = var.domain_name,
      zone_id = data.aws_route53_zone.zone.id
    }
  ]

  region  = "us-east-1"
}
