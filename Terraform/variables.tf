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
  default = "arn:aws:iam::960900884732:instance-profile/jenkins-instance-profile"
}
