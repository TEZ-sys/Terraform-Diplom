output "aws_instance_public_ip" {
  value = aws_subnet.public_subnets.id
}

output "aws_nat_gateway" {
  value = aws_nat_gateway.NATgw.id
}

output "data_aws_ami" {
  value = data.aws_ami.latest_ubuntu.id
}