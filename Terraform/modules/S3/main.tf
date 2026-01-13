resource "aws_s3_bucket" "this" {
  bucket = "${var.env}-app-bucket-12345"

  tags = {
    Environment = var.env
  }
}
