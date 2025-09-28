# 1) S3 버킷
resource "aws_s3_bucket" "static_site" {
  bucket        = var.bucket_name
  force_destroy = true

  tags = {
    Project = "static-website"
  }
}

# 2) 퍼블릭 접근 차단 해제 (정적 웹사이트 공개용)
resource "aws_s3_bucket_public_access_block" "static_site_access" {
  bucket                  = aws_s3_bucket.static_site.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# 3) 정적 웹사이트 설정 (index.html / error.html)
resource "aws_s3_bucket_website_configuration" "static_website_config" {
  bucket = aws_s3_bucket.static_site.id

  index_document {
    suffix = "index.html"
  }
}

# 4) 모든 객체에 대한 읽기(GetObject) 허용 버킷 정책
#    - PublicAccessBlock 을 먼저 적용한 뒤 정책을 적용하도록 depends_on 추가
resource "aws_s3_bucket_policy" "static_site_policy" {
  bucket = aws_s3_bucket.static_site.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowPublicReadForStaticWebsite"
        Effect    = "Allow"
        Principal = "*"
        Action    = ["s3:GetObject"]
        Resource  = "${aws_s3_bucket.static_site.arn}/*"
      }
    ]
  })

  depends_on = [aws_s3_bucket_public_access_block.static_site_access]
}
