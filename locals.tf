locals {
  bucket_name = "jetsite-${var.website_name}"
  logs_bucket_name = "${local.bucket_name}-logs"

  alias_name    = aws_cloudfront_distribution.cdn.domain_name
  alias_zone_id = aws_cloudfront_distribution.cdn.hosted_zone_id

  domain_name = var.domain_name
}
