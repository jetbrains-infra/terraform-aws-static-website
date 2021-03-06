resource "aws_route53_record" "app" {
  name    = var.domain_name
  type    = "A"
  zone_id = data.aws_route53_zone.zone.id

  alias {
    evaluate_target_health = false
    name                   = local.alias_name
    zone_id                = local.alias_zone_id
  }
}

resource "aws_route53_record" "appv6" {
  count   = var.register_ipv6 ? 1: 0
  name    = var.domain_name
  type    = "AAAA"
  zone_id = data.aws_route53_zone.zone.id

  alias {
    evaluate_target_health = false
    name                   = local.alias_name
    zone_id                = local.alias_zone_id
  }
}
