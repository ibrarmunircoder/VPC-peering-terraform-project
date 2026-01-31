locals {
  len_app_subnets    = length(var.app_subnets)
  len_public_subnets = length(var.public_subnets)
  vpc_id             = aws_vpc.vpc.id
}

resource "aws_vpc" "vpc" {
  region = var.region

  cidr_block           = var.cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.name}-vpc"
  }
}

locals {
  create_app_subnets    = local.len_app_subnets > 0
  create_public_subnets = local.len_public_subnets > 0
}


resource "aws_subnet" "app_subnet" {
  count             = local.create_app_subnets ? local.len_app_subnets : 0
  region            = var.region
  vpc_id            = local.vpc_id
  cidr_block        = element(var.app_subnets, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = format("${var.name}-app-subnet-%s", element(var.azs, count.index))
  }
}

resource "aws_route_table" "app" {
  count  = local.create_app_subnets ? local.len_app_subnets : 0
  region = var.region

  vpc_id = local.vpc_id

  tags = {
    Name = "${var.name}-app-route-table-${element(var.azs, count.index)}"
  }
}

resource "aws_route_table_association" "app" {
  count = local.create_app_subnets ? local.len_app_subnets : 0

  region = var.region

  subnet_id      = element(aws_subnet.app_subnet[*].id, count.index)
  route_table_id = element(aws_route_table.app[*].id, count.index)
}

resource "aws_subnet" "public_subnet" {
  count                   = local.create_public_subnets ? local.len_public_subnets : 0
  region                  = var.region
  vpc_id                  = local.vpc_id
  cidr_block              = element(var.public_subnets, count.index)
  availability_zone       = element(var.azs, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = format("${var.name}-public-subnet-%s", element(var.azs, count.index))
  }
}

resource "aws_route_table" "public" {
  count  = local.create_public_subnets ? local.len_public_subnets : 0
  region = var.region

  vpc_id = local.vpc_id

  tags = {
    Name = "${var.name}-public-route-table-${element(var.azs, count.index)}"
  }
}

resource "aws_route_table_association" "public" {
  count = local.create_public_subnets ? local.len_public_subnets : 0

  region = var.region

  subnet_id      = element(aws_subnet.public_subnet[*].id, count.index)
  route_table_id = element(aws_route_table.public[*].id, count.index)
}



resource "aws_internet_gateway" "this" {
  count = local.create_public_subnets && var.create_igw ? 1 : 0

  region = var.region

  vpc_id = local.vpc_id

  tags = {
    Name = "${var.name}-igw"
  }
}


resource "aws_route" "public_internet_gateway" {
  count = local.create_public_subnets && var.create_igw ? local.len_public_subnets : 0

  region = var.region

  route_table_id         = aws_route_table.public[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this[0].id


}