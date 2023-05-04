#---------------------------------Elastic-Load-Balancer----------------------------
resource "aws_elb" "elb" {
  name = "terraform-elb"
  subnets                   = [aws_subnet.public_subnets.id, aws_subnet.public_subnets2.id, aws_subnet.public_subnets3.id]
  cross_zone_load_balancing = true

  health_check  {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    target              = "HTTP:3000/"
  }
  

  listener{
    lb_port           = 3000
    lb_protocol       = "http"
    instance_port     = "3000"
    instance_protocol = "http"
 }

  listener{
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  listener{
    instance_port     = 5000
    instance_protocol = "http"
    lb_port           = 5000
    lb_protocol       = "http"
  }
}

#---------------------------------Elastic-Load-Balancer----------------------------
resource "aws_elb" "elb_ff" {
  provider = aws.reg_FF
  name = "terraform-elb"
  subnets                   = [aws_subnet.public_subnets4.id, aws_subnet.public_subnets5.id, aws_subnet.public_subnets6.id]
  cross_zone_load_balancing = true

  health_check  {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    target              = "HTTP:3000/"
  }
  

  listener{
    lb_port           = 3000
    lb_protocol       = "http"
    instance_port     = "3000"
    instance_protocol = "http"
 }

  listener{
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  listener{
    instance_port     = 5000
    instance_protocol = "http"
    lb_port           = 5000
    lb_protocol       = "http"
  }
}