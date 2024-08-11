terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.58.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.2"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "random_id" "random_s3_bucket_id" {
  byte_length = 8
}

resource "aws_s3_bucket" "tf-demo-website" {
  bucket = "tf-demo-website-${random_id.random_s3_bucket_id.hex}"
}

resource "aws_s3_bucket_public_access_block" "tf-demo-website-puclic-access" {
  bucket = aws_s3_bucket.tf-demo-website.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = aws_s3_bucket.tf-demo-website.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicReadGetObject",
        Effect    = "Allow",
        Principal = "*",
        Action = [
          "s3:GetObject"
        ],
        Resource = "${aws_s3_bucket.tf-demo-website.arn}/*"
      }
    ]
  })
}

resource "aws_s3_bucket_website_configuration" "example" {
  bucket = aws_s3_bucket.tf-demo-website.id

  index_document {
    suffix = "index.html"
  }

}

resource "aws_s3_object" "index_html" {
  bucket       = aws_s3_bucket.tf-demo-website.bucket
  key          = "index.html"
  source       = "./code/index.html"
  content_type = "text/html"
}

resource "aws_s3_object" "style_css" {
  bucket       = aws_s3_bucket.tf-demo-website.bucket
  key          = "styles.css"
  source       = "./code/styles.css"
  content_type = "text/css"
}
