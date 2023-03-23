terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.5.0"
    }
  }
}
#-----------------------------------provider_"aws" ------------------------------

provider "aws" {
  region = var.region
}

#--------------------------------------aws_instance------------------------------

resource "aws_instance" "diplom" {
  ami                    = var.ami
  instance_type          = var.type
  vpc_security_group_ids = ["${aws_security_group.sg.id}"]
  subnet_id              = aws_subnet.public_subnets.id
  user_data              = file("Data.tpl")
  tags                   = { Name = "aws_instance_diplom" }
}

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

  tags = { Name = "IGW_diplom" }
}

#---------------------------------public_subnets---------------------------------

resource "aws_subnet" "public_subnets" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnets
  map_public_ip_on_launch = "true"
  tags                    = { Name = "Public_subnet" }
}

#--------------------------------private_subnets---------------------------------

resource "aws_subnet" "private_subnets" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.private_subnets
  tags       = { Name = "Private_subnet" }
}

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

#--------------------------------Autoscale----------------------------------------

resource "aws_launch_configuration" "diplom_lc" {
  image_id        = var.ami
  instance_type   = var.type
  security_groups = [aws_security_group.sg.id]
  user_data       = file("Data.tpl")
}

resource "aws_autoscaling_group" "diplom_asg" {
  name                 = "diplom-asg"
  max_size             = var.max_size
  min_size             = var.min_size
  desired_capacity     = var.desired_capacity
  health_check_grace_period = 300
  health_check_type    = "EC2"
  launch_configuration = aws_launch_configuration.diplom_lc.name
  vpc_zone_identifier  = [aws_subnet.public_subnets.id]

  tag {
    key                 = "Name"
    value               = "aws_instance_diplom"
    propagate_at_launch = true
  }
}





