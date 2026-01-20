variable "aws_region" {
  default = "eu-north-1"
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
