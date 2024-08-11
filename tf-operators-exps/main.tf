terraform {
  
}

variable "users_list" {
  type = list(object({
    fname = string
    lname = string
  }))
  default = [ {
    fname = "Akshay"
    lname = "Saxena"
  } ]
}

# Calculations
locals {
  mul = 2*2
  add = 2+2
  eq = 2!=3
}

output "calculations-results" {
    value = local.add
}