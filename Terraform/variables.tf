variable "aws_region" {
  default = "ap-south-1"
}

variable "environment" {
  default = "dev"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ami_id" {
  description = "Amazon Linux AMI"
  default = data.aws_ami.aws_ami_name.id
}

variable "count" {
  type = number
  default = 1
}
