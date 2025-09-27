variable "bucket_name" {
  description = "This is my bucket name"
  type        = string
}
variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-northeast-2"
}