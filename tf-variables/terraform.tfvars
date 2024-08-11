instance_type = "t3.micro"
ec2_config = {
  v_size = 20
  v_type = "gp3"
}

tags = {
  "Environment" = "staging"
  "Project" = "terraform-demo"
}