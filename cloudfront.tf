resource "aws_cloudfront_origin_access_identity" "default" {
  count = var.use_s3_origin_identity ? 1 : 0
}

resource "aws_cloudfront_distribution" "cdn" {
  enabled             = true
  default_root_object = "index.html"
  is_ipv6_enabled     = true

  origin {
    domain_name = aws_s3_bucket.bucket.website_endpoint
    origin_id   = "origin.${local.domain_name}"

    dynamic "s3_origin_config" {
      iterator = access
      for_each = aws_cloudfront_origin_access_identity.default.*.cloudfront_access_identity_path
      content {
        origin_access_identity = access.value
      }
    }

    dynamic "custom_origin_config" {
      for_each = var.use_s3_origin_identity ? list("1") : list()
      content {
        http_port              = 80
        https_port             = 443
        origin_protocol_policy = "http-only"
        origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
      }
    }
  }

  default_cache_behavior {
    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]

    forwarded_values {
      cookies {
        forward = "none"
      }

      query_string = var.forward_query_string
    }

    target_origin_id       = "origin.${local.domain_name}"
    viewer_protocol_policy = "redirect-to-https"
    dynamic "lambda_function_association" {
      iterator = lambda
      for_each = var.lambda_associations
      content {
        event_type = lambda.value["event_type"]
        lambda_arn = lambda.value["lambda_arn"]
      }
    }
  }

  web_acl_id = var.waf_id

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = false
    acm_certificate_arn            = module.certificate.arn
    ssl_support_method             = "sni-only"
    minimum_protocol_version       = "TLSv1.1_2016"
  }

  aliases = [
    local.domain_name,
  ]
}
