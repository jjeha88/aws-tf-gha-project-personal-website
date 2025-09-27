terraform {
  required_version = ">= 1.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }

  # 원격 상태(backend) 설정: S3 + DynamoDB Lock
  backend "s3" {
    bucket         = "my-terrastate"                    # ← 강의에서 만든 S3 버킷 이름
    key            = "github-actions/terraform.tfstate" # ← 버킷 내부 경로/파일명
    region         = "ap-northeast-2"                   # ← 버킷 리전
    dynamodb_table = "tf-resource-gha-lock"             # ← 강의에서 만든 DynamoDB 테이블(Partition key: LockID)
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
}
