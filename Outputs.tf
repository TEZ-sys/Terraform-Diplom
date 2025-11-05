output "data_aws_ami" {
  value = data.aws_ami.latest_ubuntu.id
}

output "elb_dns_name" {
  value = aws_elb.elb.dns_name
}

output "elb_dns_name_FF" {
  value = aws_elb.elb_ff.dns_name
}