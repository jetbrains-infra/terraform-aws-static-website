output "bucket_name" {
  value = aws_s3_bucket.bucket.id
}

output "cf_distribution_id" {
  value = aws_cloudfront_distribution.cdn.id
}

output "bucket_website_endpoint" {
  value = aws_s3_bucket.bucket.website_endpoint
}

output "cf_distribution_aliases" {
  value = aws_cloudfront_distribution.cdn.aliases
}