#---------------------------------aws_security_group-----------------------------
resource "aws_security_group" "sg_elb_FF" {
  provider    = aws.reg_FF
  name        = "Security-Group for elb"
  description = "Security-Group for ELB security group"
  vpc_id      = aws_vpc.vpc2.id

   dynamic "ingress" {
    for_each = var.ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = var.CIDR
    }
  }
    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.CIDR
  }
  
  tags = {
    Name = "example_elb"
  }
}
resource "aws_security_group" "sg2" {
  provider    = aws.reg_FF
  name        = "Security-Group for Diplom"
  description = "Security group for EC2 AWS Diplom"

  vpc_id = aws_vpc.vpc2.id

  dynamic "ingress" {
    for_each = var.ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = var.CIDR
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.CIDR
  }
  tags = { Name = "sg2_diplom" }
}

#------------------------------------aws_vpc-------------------------------------

resource "aws_vpc" "vpc2" {
  provider         = aws.reg_FF
  cidr_block       = var.main_vpc_cidr2
  instance_tenancy = "default"
  tags             = { Name = "vpc_diplom" }
}

#--------------------------------aws_internet_gateway----------------------------

resource "aws_internet_gateway" "IGW2" {
  provider = aws.reg_FF
  vpc_id   = aws_vpc.vpc2.id
  tags     = { Name = "IGW2_diplom" }
}

#---------------------------------public_subnets2---------------------------------

resource "aws_subnet" "public_subnets4" {
  provider                = aws.reg_FF
  availability_zone       = var.zone2[0]
  vpc_id                  = aws_vpc.vpc2.id
  cidr_block              = var.public_subnets4
  map_public_ip_on_launch = "true"
  tags                    = { Name = "Public_subnet4" }
}

resource "aws_subnet" "public_subnets5" {
  provider                = aws.reg_FF
  availability_zone       = var.zone2[1]
  vpc_id                  = aws_vpc.vpc2.id
  cidr_block              = var.public_subnets5
  map_public_ip_on_launch = "true"
  tags                    = { Name = "Public_subnet5" }
}

resource "aws_subnet" "public_subnets6" {
  provider                = aws.reg_FF
  availability_zone       = var.zone2[2]
  vpc_id                  = aws_vpc.vpc2.id
  cidr_block              = var.public_subnets6
  map_public_ip_on_launch = "true"
  tags                    = { Name = "Public_subnet6" }
}
#--------------------------------private_subnets2---------------------------------

resource "aws_subnet" "private_subnets2" {
  provider   = aws.reg_FF
  vpc_id     = aws_vpc.vpc2.id
  cidr_block = var.private_subnets2
  tags       = { Name = "Private_subnet" }

}

#------------------------------------PublicRT2------------------------------------

resource "aws_route_table" "PublicRT2" {
  vpc_id   = aws_vpc.vpc2.id
  provider = aws.reg_FF
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW2.id

  }
  tags = { Name = "PublicRT2_diplom" }
}

#------------------------------------PrivateRT2-----------------------------------

resource "aws_route_table" "PrivateRT2" {
  provider = aws.reg_FF
  vpc_id   = aws_vpc.vpc2.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NATgw2.id

  }
  tags = { Name = "PrivateRT2_diplom" }
}

#--------------------------------PublicRT2association-----------------------------

resource "aws_route_table_association" "PublicRTassociation4" {
  provider       = aws.reg_FF
  subnet_id      = aws_subnet.public_subnets4.id
  route_table_id = aws_route_table.PublicRT2.id
}
resource "aws_route_table_association" "PublicRTassociation5" {
  provider       = aws.reg_FF
  subnet_id      = aws_subnet.public_subnets5.id
  route_table_id = aws_route_table.PublicRT2.id
}
resource "aws_route_table_association" "PublicRTassociation6" {
  provider       = aws.reg_FF
  subnet_id      = aws_subnet.public_subnets6.id
  route_table_id = aws_route_table.PublicRT2.id
}
#---------------------------------PrivateRT2association---------------------------

resource "aws_route_table_association" "PrivateRTassociation2" {
  provider       = aws.reg_FF
  subnet_id      = aws_subnet.private_subnets2.id
  route_table_id = aws_route_table.PrivateRT2.id
}

#-------------------------------------aws_eip------------------------------------

resource "aws_eip" "nateIP2" {
  provider = aws.reg_FF
  vpc      = true
  tags     = { Name = "nateIP2_diplom" }
}

#--------------------------------aws_nat_gateway---------------------------------

resource "aws_nat_gateway" "NATgw2" {
  provider      = aws.reg_FF
  allocation_id = aws_eip.nateIP2.id
  subnet_id     = aws_subnet.public_subnets4.id
  tags          = { Name = "NATgw2_diplom" }
}

