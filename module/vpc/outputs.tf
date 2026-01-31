output "public_subnet_ids" {
  value = aws_subnet.public_subnet[*].id
}
output "app_subnet_ids" {
  value = aws_subnet.app_subnet[*].id
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "vpc_cidr" {
  value = aws_vpc.vpc.cidr_block
}

output "app_rt_ids" {
  value = aws_route_table.app[*].id
}
output "public_rt_ids" {
  value = aws_route_table.public[*].id
}
