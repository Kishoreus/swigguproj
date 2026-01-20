resource "aws_instance" "EC2" {
  count                  = var.i_count
  ami                    = var.ami_id
  instance_type           = var.instance_type
  subnet_id               = var.subnet_id
  vpc_security_group_ids  = [var.security_group]

  tags = {
    Name = "${var.env}-ec2"
  }
}
