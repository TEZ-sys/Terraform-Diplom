#---------------------------------aws_security_group-----------------------------

resource "aws_security_group" "sg" {
  name        = "Security-Group for Diplom"
  description = "Security group for EC2 AWS Diplom"

  vpc_id = aws_vpc.vpc.id

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
  tags = { Name = "SG_diplom" }
}

#------------------------------------aws_vpc-------------------------------------

resource "aws_vpc" "vpc" {

  cidr_block       = var.main_vpc_cidr
  instance_tenancy = "default"

  tags = { Name = "vpc_diplom" }
}

#--------------------------------aws_internet_gateway----------------------------

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.vpc.id
  tags   = { Name = "IGW_diplom" }
}

#---------------------------------public_subnets---------------------------------

resource "aws_subnet" "public_subnets" {
  availability_zone       = var.zone[0]
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnets
  map_public_ip_on_launch = "true"

  tags = { Name = "Public_subnet" }
}

resource "aws_subnet" "public_subnets2" {
  availability_zone       = var.zone[1]
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnets2
  map_public_ip_on_launch = "true"

  tags = { Name = "Public_subnet2" }
}
resource "aws_subnet" "public_subnets3" {
  availability_zone       = var.zone[2]
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnets3
  map_public_ip_on_launch = "true"

  tags = { Name = "Public_subnet3" }
}

#--------------------------------private_subnets---------------------------------

resource "aws_subnet" "private_subnets" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnets
  tags              = { Name = "Private_subnet" }

}
#resource "aws_subnet" "private_subnets2" {
#  availability_zone = var.zone
#  vpc_id     = aws_vpc.vpc.id
#  cidr_block = var.private_subnets2
#  tags       = { Name = "Private_subnet" }
#
#}
#------------------------------------PublicRT------------------------------------

resource "aws_route_table" "PublicRT" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id

  }
  tags = { Name = "PublicRT_diplom" }
}

#------------------------------------PrivateRT-----------------------------------

resource "aws_route_table" "PrivateRT" {

  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NATgw.id

  }
  tags = { Name = "PrivateRT_diplom" }
}

#--------------------------------PublicRTassociation-----------------------------

resource "aws_route_table_association" "PublicRTassociation" {

  subnet_id      = aws_subnet.public_subnets.id
  route_table_id = aws_route_table.PublicRT.id
}
resource "aws_route_table_association" "PublicRTassociation2" {

  subnet_id      = aws_subnet.public_subnets2.id
  route_table_id = aws_route_table.PublicRT.id
}
resource "aws_route_table_association" "PublicRTassociation3" {

  subnet_id      = aws_subnet.public_subnets3.id
  route_table_id = aws_route_table.PublicRT.id
}
#---------------------------------PrivateRTassociation---------------------------

resource "aws_route_table_association" "PrivateRTassociation" {

  subnet_id      = aws_subnet.private_subnets.id
  route_table_id = aws_route_table.PrivateRT.id
}

#-------------------------------------aws_eip------------------------------------

resource "aws_eip" "nateIP" {

  vpc  = true
  tags = { Name = "nateIP_diplom" }
}

#--------------------------------aws_nat_gateway---------------------------------

resource "aws_nat_gateway" "NATgw" {

  allocation_id = aws_eip.nateIP.id
  subnet_id     = aws_subnet.public_subnets.id
  tags          = { Name = "NATgw_diplom" }
}
