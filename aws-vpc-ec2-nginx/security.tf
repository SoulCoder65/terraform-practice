resource "aws_security_group" "tf-nginx-security" {
  vpc_id = aws_vpc.tf-vpc-nginx.id

  #   Inbound rule for http
  ingress {
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"

  }

  # Outbound rule for http
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = merge(
        var.tags,
        {
            Name:"tf-nginx-sg"
        }
    )
}
