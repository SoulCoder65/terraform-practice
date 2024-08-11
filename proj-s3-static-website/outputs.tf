output "tf-demo-website-url" {
  value = aws_s3_bucket.tf-demo-website.website_endpoint 
}