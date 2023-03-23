output "aws_instance_id" {
  value = aws_instance.diplom.id
}

output "aws_instance_public_ip" {
  value = aws_subnet.public_subnets.id
}

output "aws_nat_gateway" {
  value = aws_nat_gateway.NATgw.id
}

output "aws_instance_IP" {
  value = aws_instance.diplom.public_ip
}
