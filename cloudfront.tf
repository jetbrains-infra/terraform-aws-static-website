resource "aws_cloudfront_distribution" "cdn" {
  enabled             = true
  default_root_object = "index.html"
  is_ipv6_enabled     = true

  origin {
    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }

    domain_name = "${aws_s3_bucket.bucket.website_endpoint}"
    origin_id   = "origin.${local.domain_name}"
  }

  "default_cache_behavior" {
    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]

    "forwarded_values" {
      "cookies" {
        forward = "none"
      }

      query_string = false
    }

    target_origin_id       = "origin.${local.domain_name}"
    viewer_protocol_policy = "redirect-to-https"
  }

  web_acl_id = "${var.waf_id}"

  "restrictions" {
    "geo_restriction" {
      restriction_type = "none"
    }
  }

  "viewer_certificate" {
    cloudfront_default_certificate = false
    acm_certificate_arn            = "${module.certificate.arn}"
    ssl_support_method             = "sni-only"
    minimum_protocol_version       = "TLSv1.1_2016"
  }

  aliases = [
    "${local.domain_name}",
  ]
}
