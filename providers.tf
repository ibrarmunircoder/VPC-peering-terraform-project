terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.30.0"
    }
  }

  required_version = "~> 1.14.3"


  backend "s3" {
    bucket       = "vpc-peering-terraform-state-01"
    key          = "vpc-peering.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}

provider "aws" {
  region = "us-east-1"
}
