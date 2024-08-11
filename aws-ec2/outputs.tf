output "aws_instance_public_ip" {
  value = aws_instance.terraform-demo-instance.public_ip
}