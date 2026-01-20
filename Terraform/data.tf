data "aws_ami" "aws_ami_name" {
  most_recent = true
  owners = ["amazon"]

filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
}
}
