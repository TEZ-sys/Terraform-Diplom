data "aws_availability_zones" "all" {}


data "aws_ami" "latest_ubuntu" {
  owners      = ["137112412989"]
  most_recent = true
  filter {
    name   = "name"
    values = ["al2023-ami-2023.0.20230419.0-kernel-6.1-x86_64"]
  }
}

data "aws_ami" "latest_ubuntu_ff" {
  provider = aws.reg_FF
  owners      = ["137112412989"]
  most_recent = true
  filter {
    name   = "name"
    values = ["al2023-ami-2023.0.20230419.0-kernel-6.1-x86_64"]
  }
}