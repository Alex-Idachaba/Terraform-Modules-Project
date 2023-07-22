provider "aws" {
  region = "us-east-1"
}

module "network-module" {
  source = "./modules/networking"
  vpc_cidr_block = var.vpc_cidr_block
  subnet_main_public_1_cidr_block = var.subnet_main_public_1_cidr_block
  subnet_main_public_2_cidr_block = var.subnet_main_public_2_cidr_block
  subnet_main_public_3_cidr_block = var.subnet_main_public_3_cidr_block
  subnet_main_private_1_cidr_block = var.subnet_main_private_1_cidr_block
  subnet_main_private_2_cidr_block = var.subnet_main_private_2_cidr_block
  subnet_main_private_3_cidr_block = var.subnet_main_private_3_cidr_block
  avail_zone1 = var.avail_zone1
  avail_zone2 = var.avail_zone2
  avail_zone3 = var.avail_zone3
  env_prefix = var.env_prefix
}

module "compute-module" {
 source = "./modules/compute"
 vpc_id = module.network-module.vpc-main.id
 my_ip = var.my_ip
 env_prefix = var.env_prefix
 image_name = var.image_name
 public_key_location = var.public_key_location
 subnet_id = module.network-module.subnet-public-1.id
 avail_zone1 = var.avail_zone1
 instance_type1 = var.instance_type1
 iam_instance_profile = module.iam-module.iam_instance_profile.name
}

module "iam-module" {
  source = "./modules/iam"
  env_prefix = var.env_prefix
}