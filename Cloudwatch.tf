resource "aws_cloudwatch_metric_alarm" "diplom-alarm-more-cpu" {

  alarm_name          = "Monitoring CPU in London (>=70%)"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "5"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = var.thread


  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.diplom_asg.name}"
  }

  actions_enabled   = true
  alarm_description = "CPU utilisation >=70%"
  alarm_actions     = [aws_autoscaling_policy.diplom-scale-out.arn]
}

resource "aws_cloudwatch_metric_alarm" "diplom-alarm-less-cpu" {

  alarm_name          = "Monitoring CPU in London (<30%)"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "5"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = var.thread_less


  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.diplom_asg.name}"
  }

  actions_enabled   = true
  alarm_description = "CPU utilisation in Londond is <=30%"
  alarm_actions     = [aws_autoscaling_policy.diplom-scale-down.arn]

}

#----------------------------------------------------------------------------------
resource "aws_cloudwatch_metric_alarm" "diplom-alarm-FF" {
  provider            = aws.reg_FF
  alarm_name          = "Monitoring CPU in FrankFurt"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = var.thread


  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.diplom_asg2.name}"
  }

  actions_enabled   = true
  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = [aws_autoscaling_policy.diplom-scale-out-FF.arn]

  ok_actions = [aws_autoscaling_policy.diplom-stop-scaling-FF.arn]

}
