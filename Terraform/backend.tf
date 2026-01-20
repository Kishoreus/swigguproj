terraform {
  backend "s3" {
    bucket  = "backend-state-bucket"
    key     = "terraform.tfstate"
    region  = "eu-north-1"
    encrypt = true
  }
}
