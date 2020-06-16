
locals {
  s3_bucket_access_all = <<EOF
{
    "Version": "2012-10-17",
    "Id": "Policy1495114717756",
    "Statement": [
        {
            "Sid": "Stmt1495114715128",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::${local.bucket_name}/*"
        }
    ]
}
EOF
}

data "aws_iam_policy_document" "s3_policy" {
  count = var.use_s3_origin_identity ? 1 :  0
  statement {
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::${local.bucket_name}/*"]

    principals {
      type        = "AWS"
      identifiers = [ aws_cloudfront_origin_access_identity.default[0].iam_arn]
    }
  }
}

resource "aws_s3_bucket" "bucket" {
  bucket = local.bucket_name
  region = var.aws_region
  acl    = "private"

  policy = var.use_s3_origin_identity ? data.aws_iam_policy_document.s3_policy[0].json : local.s3_bucket_access_all

  website {
    index_document = "index.html"
    error_document = "index.html"
  }
}
