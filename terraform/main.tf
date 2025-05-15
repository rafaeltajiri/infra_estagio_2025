
provider "aws" {
  region = var.region
}

module "network" {
  source  = "./modules/network"
  project = var.project
  region  = var.region
}

module "ec2" {
  source      = "./modules/ec2"
  project     = var.project
  estagiarios = var.estagiarios
  subnet_id   = module.network.public_subnet_id
  sg_id       = module.network.sg_id
}

module "rds" {
  source            = "./modules/rds"
  project           = var.project
  private_subnet_id = module.network.private_subnet_id
  sg_id             = module.network.sg_id
}

module "iam" {
  source      = "./modules/iam"
  estagiarios = var.estagiarios
}
