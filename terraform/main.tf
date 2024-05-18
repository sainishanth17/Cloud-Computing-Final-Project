terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 1.0.0"
}

provider "aws" {
  region = var.region
}

module "s3" {
  source      = "./modules/s3"
  bucket_name = "ss-final-image-bucket"
}

module "iam" {
  source           = "./modules/iam"
  image-bucket-arn = module.s3.image-bucket-arn
}

module "vpc" {
  source                = "./modules/vpc"
  region                = var.region
  vpc_cidr              = "172.31.0.0/16"
  public_sub_1_cidr     = "172.31.1.0/24"
  public_sub_2_cidr     = "172.31.2.0/24"
  public_sub_3_cidr     = "172.31.3.0/24"
  private_sub_1_cidr    = "172.31.4.0/24"
  private_sub_2_cidr    = "172.31.5.0/24"
  private_sub_3_cidr    = "172.31.6.0/24"
  private_db_sub_1_cidr = "172.31.7.0/24"
  private_db_sub_2_cidr = "172.31.8.0/24"
  private_db_sub_3_cidr = "172.31.9.0/24"
  availability_zone_1   = "${var.region}a"
  availability_zone_2   = "${var.region}b"
  availability_zone_3   = "${var.region}c"
}

module "rds" {
  source            = "./modules/rds"
  db_instance_class = "db.t2.micro"
  db_admin_username = "admin"
  db_admin_password = var.db_admin_password
  db_sg_id          = module.vpc.db_security_group_id
  db_subnet_ids = [
    module.vpc.private_db_sub_1_id,
    module.vpc.private_db_sub_2_id,
    module.vpc.private_db_sub_3_id,
  ]
}

module "compute" {
  source                     = "./modules/compute"
  region                     = var.region
  instance_profile_name      = module.iam.instance_profile_name
  private_availability_zones = ["${var.region}a", "${var.region}b", "${var.region}c"]
  private_security_group_id  = module.vpc.private_security_group_id
  private_subnet_ids = [
    module.vpc.private_sub_1_id,
    module.vpc.private_sub_2_id,
    module.vpc.private_sub_3_id,
  ]
  target_group_arn = module.lb.target_group_arn
  bucket_name      = var.bucket_name
  db_user          = "web-app"
  db_name          = "social_something"
  db_password      = var.db_password
  db_host          = module.rds.db_host
}

module "lb" {
  source                   = "./modules/lb"
  vpc_id                   = module.vpc.vpc_id
  ssl_cert_arn             = module.route53.ssl_cert_arn
  public_security_group_id = module.vpc.public_security_group_id
  public_subnet_ids = [
    module.vpc.public_sub_1_id,
    module.vpc.public_sub_2_id,
    module.vpc.public_sub_3_id
  ]
}


module "route53" {
  source = "./modules/route53"
  #joke domain :)
  domain_name    = "racistzebra.com"
  subdomain_name = "final"
  alb_hostname   = module.lb.alb_hostname
  alb_zone_id    = module.lb.alb_zone_id
}

