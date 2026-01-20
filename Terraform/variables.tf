variable "aws_region" {
  default = "ap-south-1"
}

variable "environment" {
  default = "dev"
}

variable "instance_type" {
  default = "t2.micro"
}


variable "i_count" {
  type = number
  default = 1
}
