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