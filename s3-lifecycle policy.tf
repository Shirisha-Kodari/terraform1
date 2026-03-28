resource "aws_s3_bucket_lifecycle_configuration" "example" {
  bucket = aws_s3_bucket.my_bucket.id

  rule {
    id     = "log-lifecycle"
    status = "Enabled"

    filter {
      prefix = "logs/"
    }

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = 60
      storage_class = "GLACIER"
    }

    expiration {
      days = 90
    }
  }
}

