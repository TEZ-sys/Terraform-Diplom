data "aws_availability_zones" "all" {}


data "aws_ami" "latest_ubuntu" {
  owners      = ["099720109477"]
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

data "aws_ami" "latest_ubuntu_ff" {
  provider    = aws.reg_FF
  owners      = ["099720109477"]
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}
data "aws_security_group" "get_name" {
  name   = aws_security_group.sg.name
  vpc_id = aws_security_group.sg.vpc_id
}