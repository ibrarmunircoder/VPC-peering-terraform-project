resource "aws_key_pair" "primary_key_pair" {
  key_name   = "primary_key_pair"
  region     = var.primary_region
  public_key = file("./primary-ins-key.pub")
}

resource "aws_key_pair" "secondary_key_pair" {
  key_name   = "secondary_key_pair"
  region     = var.secondary_region
  public_key = file("./secondary-ins-key.pub")
}


resource "aws_instance" "primary_instance" {
  region                 = var.primary_region
  ami                    = lookup(local.amis_by_region, var.primary_region)
  instance_type          = "t3.micro"
  tenancy                = "default"
  subnet_id              = module.primary_vpc.app_subnet_ids[0]
  vpc_security_group_ids = [aws_security_group.primary_app_ins_sg.id]
  key_name               = aws_key_pair.primary_key_pair.key_name


  tags = {
    Name = "Primary-app-Instance"

  }

}
resource "aws_instance" "bastion_instance" {
  region                 = var.primary_region
  ami                    = lookup(local.amis_by_region, var.primary_region)
  instance_type          = "t3.micro"
  tenancy                = "default"
  subnet_id              = module.primary_vpc.public_subnet_ids[0]
  vpc_security_group_ids = [aws_security_group.primary_jumpbox_ins_sg.id]
  key_name               = aws_key_pair.primary_key_pair.key_name


  tags = {
    Name = "Primary-Jumbox-Instance"

  }

}


resource "aws_instance" "secondary_instance" {
  region                 = var.secondary_region
  ami                    = lookup(local.amis_by_region, var.secondary_region)
  instance_type          = "t3.micro"
  tenancy                = "default"
  subnet_id              = module.secondary_vpc.app_subnet_ids[0]
  vpc_security_group_ids = [aws_security_group.secondary_app_ins_sg.id]
  key_name               = aws_key_pair.secondary_key_pair.key_name


  tags = {
    Name = "Secondary-app-Instance"

  }

}