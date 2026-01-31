resource "aws_vpc_peering_connection" "primary_to_secondary" {
  region      = var.primary_region
  vpc_id      = module.primary_vpc.vpc_id
  peer_vpc_id = module.secondary_vpc.vpc_id
  peer_region = var.secondary_region
  auto_accept = false

  tags = {
    Name = "Primary-to-Secondary-Peering"
    Side = "Requester"
  }
}

resource "aws_vpc_peering_connection_accepter" "secondary_accepter" {
  region                    = var.secondary_region
  vpc_peering_connection_id = aws_vpc_peering_connection.primary_to_secondary.id
  auto_accept               = true

  tags = {
    Name = "Secondary-Peering-Accepter"
    Side = "Accepter"
  }
}

# Add route to Secondary VPC in Primary route table
resource "aws_route" "primary_to_secondary" {
  region                    = var.primary_region
  route_table_id            = module.primary_vpc.app_rt_ids[0]
  destination_cidr_block    = module.secondary_vpc.vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.primary_to_secondary.id

  depends_on = [aws_vpc_peering_connection_accepter.secondary_accepter]
}
resource "aws_route" "primary_to_secondary_public_rt" {
  region                    = var.primary_region
  route_table_id            = module.primary_vpc.public_rt_ids[0]
  destination_cidr_block    = module.secondary_vpc.vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.primary_to_secondary.id

  depends_on = [aws_vpc_peering_connection_accepter.secondary_accepter]
}

# Add route to Primary VPC in Secondary route table
resource "aws_route" "secondary_to_primary" {
  region                    = var.secondary_region
  route_table_id            = module.secondary_vpc.app_rt_ids[0]
  destination_cidr_block    = module.primary_vpc.vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.primary_to_secondary.id

  depends_on = [aws_vpc_peering_connection_accepter.secondary_accepter]
}