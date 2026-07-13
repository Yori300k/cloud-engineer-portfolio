terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "networking" {
  source      = "./modules/networking"
  name_prefix = "p15"
}

module "web_fleet" {
  source      = "./modules/web-fleet"
  name_prefix = "p15"
  vpc_id      = module.networking.vpc_id
  subnet_ids  = module.networking.public_subnet_ids
}

output "alb_dns" {
  value = module.web_fleet.alb_dns_name
}


