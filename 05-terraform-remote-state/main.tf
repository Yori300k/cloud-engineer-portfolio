terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "cloud-portfolio-terraform-state-yori"
    key            = "05-remote-state/terraform.tfstate"
    region         = "us-east-1"
    use_lockfile   = "true"
    encrypt        = true
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "remote-state-test-vpc"
  }
}
