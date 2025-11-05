resource "aws_autoscaling_policy" "diplom-scale-out" {
  name                   = "diplom-scale-out-policy"
  policy_type            = "SimpleScaling"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = 1
  autoscaling_group_name = aws_autoscaling_group.diplom_asg.name

}

resource "aws_autoscaling_policy" "diplom-stop-scaling" {
  name                   = "stop-scaling"
  policy_type            = "SimpleScaling"
  adjustment_type        = "ExactCapacity"
  scaling_adjustment     = 0
  autoscaling_group_name = aws_autoscaling_group.diplom_asg.name
}

#-----------------------------------------------------------------------

resource "aws_autoscaling_policy" "diplom-scale-out-FF" {
  provider               = aws.reg_FF
  name                   = "diplom-scale-out-policy"
  policy_type            = "SimpleScaling"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = 1
  autoscaling_group_name = aws_autoscaling_group.diplom_asg2.name

}

resource "aws_autoscaling_policy" "diplom-stop-scaling-FF" {
  provider               = aws.reg_FF
  name                   = "stop-scaling"
  policy_type            = "SimpleScaling"
  adjustment_type        = "ExactCapacity"
  scaling_adjustment     = 0
  autoscaling_group_name = aws_autoscaling_group.diplom_asg2.name
}