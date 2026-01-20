module "vpc" {
  source = "./modules/VPC"
  env    = var.environment
}

module "sg" {
  source = "./modules/sg"
  vpc_id = module.vpc.vpc_id
  env    = var.environment
}

module "ec2" {
  source          = "./modules/EC2"
  count           = var.count
  ami_id          = var.ami_id
  instance_type   = var.instance_type
  subnet_id       = module.vpc.public_subnet_id
  security_group  = module.sg.sg_id
  env             = var.environment
}

