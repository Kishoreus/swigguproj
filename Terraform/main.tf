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
  source                 = "./modules/EC2"
  i_count                = var.i_count
  ami_id                 = data.aws_ami.aws_ami_name.id
  instance_type          = var.instance_type
  instance_profile       = var.instance_profile
  subnet_id              = module.vpc.public_subnet_id
  security_group         = module.sg.sg_id
  env                    = var.environment
}

