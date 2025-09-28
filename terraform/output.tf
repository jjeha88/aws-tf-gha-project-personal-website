output "bucket_name" {
  value       = aws_s3_bucket.static_site.bucket
  description = "정적 웹사이트 S3 버킷 이름"
}

output "website_endpoint" {
  value       = aws_s3_bucket_website_configuration.static_website_config.website_endpoint
  description = "S3 정적 웹사이트 엔드포인트 (http)"
}