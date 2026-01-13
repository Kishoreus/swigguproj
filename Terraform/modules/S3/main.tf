resource "aws_s3_bucket" "s3b" {
  bucket = "${var.env}-app-bucket-12-345"

  tags = {
    Environment = var.env
  }
}
