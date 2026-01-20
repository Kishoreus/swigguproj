terraform {
  backend "s3" {
    bucket  = "backend-state-bucket1"
    key     = "terraform.tfstate"
    region  = "eu-north-1"
    encrypt = true
  }
}
