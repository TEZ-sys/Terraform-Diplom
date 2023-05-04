resource "aws_launch_configuration" "diplom_lc_ff" {
  provider        = aws.reg_FF
  image_id        = coalesce(var.ami, data.aws_ami.latest_ubuntu_ff.id)
  instance_type   = var.type
  security_groups = [aws_security_group.sg2.id]
  user_data       = file("Data.tpl")
}

resource "aws_launch_configuration" "diplom_lc" {

  image_id        = coalesce(var.ami, data.aws_ami.latest_ubuntu.id)
  instance_type   = var.type
  security_groups = [aws_security_group.sg.id]
  user_data       = file("Data.tpl")

}

resource "aws_autoscaling_group" "diplom_asg" {

  name             = "diplom-asg"
  max_size         = var.max_size
  min_size         = var.min_size

  launch_configuration = aws_launch_configuration.diplom_lc.name
  vpc_zone_identifier  = [aws_subnet.public_subnets.id,aws_subnet.public_subnets.id2,aws_subnet.public_subnets3.id]

  health_check_grace_period = 300
  health_check_type         = "EC2"
  load_balancers            = [aws_elb.elb.id]
  #target_group_arns = [
  #  aws_lb_target_group.lb_target.arn
  #]

  tag {
    key                 = "ASG"
    value               = "aws_instance_diplom-ASG"
    propagate_at_launch = true
  }

}


resource "aws_autoscaling_group" "diplom_asg2" {
  provider         = aws.reg_FF
  name             = "diplom-asg"
  max_size         = var.max_size
  min_size         = var.min_size

  launch_configuration = aws_launch_configuration.diplom_lc_ff.name
  vpc_zone_identifier  = [aws_subnet.public_subnets4.id, aws_subnet.public_subnets5.id, aws_subnet.public_subnets6.id]

  health_check_grace_period = 300
  health_check_type         = "EC2"
  load_balancers            = [aws_elb.elb_ff.id]
  #target_group_arns = [
  #  aws_lb_target_group.lb_target.arn
  #]

  tag {
    key                 = "ASG"
    value               = "aws_instance_diplom-ASG_ff"
    propagate_at_launch = true
  }
}
