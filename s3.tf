resource "aws_s3_bucket" "bucket" {
  bucket = local.bucket_name
  region = var.aws_region
  acl    = "private"

  policy = <<EOF
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

  website {
    index_document = "index.html"
    error_document = "index.html"
  }
}
