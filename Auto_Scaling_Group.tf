resource "aws_launch_template" "diplom_lt" {

  name_prefix            = "Default-London-instance-"
  image_id               = coalesce(var.ami, data.aws_ami.latest_ubuntu.id)
  instance_type          = var.type
  vpc_security_group_ids = [aws_security_group.sg.id]
  user_data              = filebase64("Data.tpl")
}

resource "aws_launch_template" "diplom_lt_ff" {

  name_prefix            = "Default-Frankfurt-instance"
  provider               = aws.reg_FF
  image_id               = coalesce(var.ami, data.aws_ami.latest_ubuntu_ff.id)
  instance_type          = var.type
  vpc_security_group_ids = [aws_security_group.sg2.id]
  user_data              = filebase64("Data.tpl")
}

resource "aws_autoscaling_group" "diplom_asg" {
  name             = "diplom-asg-london"
  max_size         = var.max_size
  min_size         = var.min_size
  desired_capacity = var.desired_capacity
  vpc_zone_identifier = [
    aws_subnet.public_subnets.id,
    aws_subnet.public_subnets2.id,
    aws_subnet.public_subnets3.id
  ]
  health_check_grace_period = 300
  health_check_type         = "ELB"
  load_balancers            = [aws_elb.elb.id]


  launch_template {
    id      = aws_launch_template.diplom_lt.id
    version = "$Latest"
  }


  tag {
    key                 = "Name"
    value               = "instance_diplom-ASG_London"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_group" "diplom_asg2" {
  provider         = aws.reg_FF
  name             = "diplom-asg-frankfurt"
  max_size         = var.max_size
  min_size         = var.min_size
  desired_capacity = var.desired_capacity
  vpc_zone_identifier = [
    aws_subnet.public_subnets4.id,
    aws_subnet.public_subnets5.id,
    aws_subnet.public_subnets6.id
  ]
  health_check_grace_period = 300
  health_check_type         = "ELB"
  load_balancers            = [aws_elb.elb_ff.id]

  launch_template {
    id      = aws_launch_template.diplom_lt_ff.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "aws_instance_diplom-ASG_Frankfurt"
    propagate_at_launch = true
  }
}


resource "aws_autoscaling_schedule" "diplom_asg_schedule" {
  scheduled_action_name  = "Scheduled London"
  min_size               = var.scheduled_min_size[0]
  max_size               = var.scheduled_max_size[0]
  desired_capacity       = var.scheduled_desired_capacity[0]
  recurrence             = "0 9 * * 1-5"
  autoscaling_group_name = aws_autoscaling_group.diplom_asg.name
}


resource "aws_autoscaling_schedule" "diplom_asg2_schedule" {
  scheduled_action_name  = "Scheduled Frankfurd"
  min_size               = var.scheduled_min_size[1]
  max_size               = var.scheduled_max_size[1]
  desired_capacity       = var.scheduled_desired_capacity[1]
  recurrence             = "0 18 * * 0-6"
  autoscaling_group_name = aws_autoscaling_group.diplom_asg.name
}