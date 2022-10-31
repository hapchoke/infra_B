terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_object" "object" {
  bucket = "own-my-terraform-bucket-1.0"
  for_each = fileset("${path.cwd}/upload_file","*")
  key    = each.value
  source = "${path.cwd}/upload_file/${each.value}"
  etag   = filemd5("${path.cwd}/upload_file/${each.value}")
}
