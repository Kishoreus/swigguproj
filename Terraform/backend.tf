terraform {
  backend "s3" {
    bucket  = "backend-state-bucket"
    key     = "terraform.tfstate"
    region  = "ap-south-1"
    encrypt = true
  }
}
