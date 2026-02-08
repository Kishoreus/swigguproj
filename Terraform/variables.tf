variable "aws_region" {
  default = "us-west-2"
}

variable "environment" {
  default = "dev"
}

variable "instance_type" {
  default = "c7i-flex.large"
}


variable "i_count" {
  type = number
  default = 2
}

variable "instance_profile" {
  default = "jenkins-instance-profile"
}
