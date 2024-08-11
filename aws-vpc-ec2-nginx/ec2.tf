
# AWS EC2
resource "aws_instance" "tf-nginx-instance" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = aws_subnet.tf-vpc-nginx-public-subnet.id
security_groups = [ aws_security_group.tf-nginx-security.id ]
  associate_public_ip_address = true
  user_data     = <<-EOF
                #!/bin/bash
                sudo yum install nginx -y
                sudo systemctl start nginx
                EOF

  tags = merge(
    var.tags,
    {
      Name : "tf-nginx-instance"
    }
  )

}
