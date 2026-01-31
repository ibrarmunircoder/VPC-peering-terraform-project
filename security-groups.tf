resource "aws_security_group" "primary_app_ins_sg" {
  region = var.primary_region
  name   = "PrimaryAppInstanceSg"
  vpc_id = module.primary_vpc.vpc_id

}

resource "aws_vpc_security_group_ingress_rule" "primary_sg_allow_icmp_from_sec_vpc" {
  region            = var.primary_region
  security_group_id = aws_security_group.primary_app_ins_sg.id
  cidr_ipv4         = module.secondary_vpc.vpc_cidr
  from_port         = -1
  ip_protocol       = "icmp"
  to_port           = -1
}

resource "aws_vpc_security_group_ingress_rule" "primary_sg_allow_ssh_from_jumpbox" {
  region                       = var.primary_region
  security_group_id            = aws_security_group.primary_app_ins_sg.id
  referenced_security_group_id = aws_security_group.primary_jumpbox_ins_sg.id
  from_port                    = 22
  ip_protocol                  = "tcp"
  to_port                      = 22
}

resource "aws_vpc_security_group_egress_rule" "primary_sg_allow_all_traffic_ipv4" {
  region            = var.primary_region
  security_group_id = aws_security_group.primary_app_ins_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_security_group" "primary_jumpbox_ins_sg" {
  region = var.primary_region
  name   = "PrimaryJumpboxInstanceSg"
  vpc_id = module.primary_vpc.vpc_id

}

resource "aws_vpc_security_group_ingress_rule" "primary_jumpbox_sg_allow_ssh" {
  region            = var.primary_region
  security_group_id = aws_security_group.primary_jumpbox_ins_sg.id
  cidr_ipv4         = var.jumbox_ingress
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "primary_jumpbox_sg_allow_all_traffic_ipv4" {
  region            = var.primary_region
  security_group_id = aws_security_group.primary_jumpbox_ins_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}


resource "aws_security_group" "secondary_app_ins_sg" {
  region = var.secondary_region
  name   = "SecondaryAppInstanceSg"
  vpc_id = module.secondary_vpc.vpc_id

}

resource "aws_vpc_security_group_ingress_rule" "secondary_sg_allow_icmp_from_primary_vpc" {
  region            = var.secondary_region
  security_group_id = aws_security_group.secondary_app_ins_sg.id
  cidr_ipv4         = module.primary_vpc.vpc_cidr
  from_port         = -1
  ip_protocol       = "icmp"
  to_port           = -1
}

resource "aws_vpc_security_group_ingress_rule" "secondary_sg_allow_ssh_from_jumpbox" {
 region            = var.secondary_region
  security_group_id = aws_security_group.secondary_app_ins_sg.id
  cidr_ipv4         = module.primary_vpc.vpc_cidr
  from_port                    = 22
  ip_protocol                  = "tcp"
  to_port                      = 22
}



resource "aws_vpc_security_group_egress_rule" "secondary_sg_allow_all_traffic_ipv4" {
  region            = var.secondary_region
  security_group_id = aws_security_group.secondary_app_ins_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}