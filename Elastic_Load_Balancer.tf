#---------------------------------Elastic-Load-Balancer----------------------------
resource "aws_elb" "elb" {
  name                      = "terraform-elb"
  subnets                   = [aws_subnet.public_subnets.id, aws_subnet.public_subnets2.id, aws_subnet.public_subnets3.id]
  cross_zone_load_balancing = true

  security_groups = [ aws_security_group.sg_elb.id ]
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    target              = "HTTP:80/"
  }

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

}

resource "aws_security_group_rule" "opened_to_elb_http" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.sg_elb.id
  security_group_id        = aws_security_group.sg_elb.id
}
resource "aws_security_group_rule" "opened_to_elb_https" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.sg_elb.id
  security_group_id        = aws_security_group.sg_elb.id
}

#---------------------------------Elastic-Load-Balancer----------------------------
resource "aws_elb" "elb_ff" {
  provider                  = aws.reg_FF
  name                      = "terraform-elb"
  subnets                   = [aws_subnet.public_subnets4.id, aws_subnet.public_subnets5.id, aws_subnet.public_subnets6.id]
  cross_zone_load_balancing = true
  security_groups = [ aws_security_group.sg_elb_FF.id ]
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    target              = "HTTP:80/"
  }

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
}
resource "aws_security_group_rule" "opened_to_elb_http_FF" {
  provider                  = aws.reg_FF
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.sg_elb_FF.id
  security_group_id        = aws_security_group.sg_elb_FF.id
}
resource "aws_security_group_rule" "opened_to_elb_https_FF" {
  provider                  = aws.reg_FF
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.sg_elb_FF.id
  security_group_id        = aws_security_group.sg_elb_FF.id
}

