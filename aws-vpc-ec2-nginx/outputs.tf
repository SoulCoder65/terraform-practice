output "tf-nginx-instance-public-ip" {
  description = "Public IP of nginx ec2 instanc"
  value = aws_instance.tf-nginx-instance.public_ip
}

output "tf-nginx-instance-url" {
  description = "Nginx ec2 instance url"
  value = "http://${aws_instance.tf-nginx-instance.public_ip}"
}