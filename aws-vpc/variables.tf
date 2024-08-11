variable "region" {
  description = "value of region"
  type        = string
  default     = "ap-south-1"
}

variable "tags" {
  type = map(string)
  default = {
    "Environment" = "dev"
    "Project"     = "terraform-vpc-demo"
  }
  description = "Tags to apply to the resources"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "Type of AWS EC2 instance"
}

variable "ami" {
  type        = string
  default     = "ami-0ec0e125bb6c6e8ec"
  description = "ami of aws ec2 instance"
}