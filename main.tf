data "aws_availability_zones" "primary" {
  region = var.primary_region
  state  = "available"
}

data "aws_availability_zones" "secondary" {
  region = var.secondary_region
  state  = "available"
}


module "primary_vpc" {
  source = "./module/vpc"

  cidr           = "10.16.0.0/16"
  name           = "primary"
  app_subnets    = ["10.16.0.0/17"]
  public_subnets = ["10.16.128.0/17"]
  region         = var.primary_region
  azs            = data.aws_availability_zones.primary.names
  create_igw     = true


}
module "secondary_vpc" {
  source = "./module/vpc"

  cidr        = "10.17.0.0/16"
  name        = "secondary"
  app_subnets = ["10.17.0.0/17"]
  region      = var.secondary_region
  azs         = data.aws_availability_zones.secondary.names


}