locals {
  aws_region = "${local.aws_region}"
  bucket_name = "jetsite-${var.website_name}"

  alias_name = "${aws_cloudfront_distribution.cdn.domain_name}"
  alias_zone_id = "${aws_cloudfront_distribution.cdn.hosted_zone_id}"

  domain_name = "${var.domain_name}"
}