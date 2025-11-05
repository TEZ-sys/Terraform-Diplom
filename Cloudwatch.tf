resource "aws_cloudwatch_metric_alarm" "diplom-alarm" {
  alarm_name          = "Monitoring CPU in London"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = var.thread


  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.diplom_asg.name}"
  }

  actions_enabled   = true
  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = [aws_autoscaling_policy.diplom-scale-out.arn]

  ok_actions = [aws_autoscaling_policy.diplom-stop-scaling.arn]

}

resource "aws_cloudwatch_metric_alarm" "disk-usage" {
  alarm_name          = "disk-usage"
  comparison_operator = var.compare
  evaluation_periods  = "2"
  metric_name         = "LogicalDisk % Free Space"
  namespace           = "CWAgent"
  period              = "300"
  statistic           = "Average"
  threshold           = var.thread

  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.diplom_asg.name}"
  }

  actions_enabled   = true
  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = [aws_autoscaling_policy.diplom-scale-out.arn]

  ok_actions = [aws_autoscaling_policy.diplom-stop-scaling.arn]
}
#----------------------------------------------------------------------------------
resource "aws_cloudwatch_metric_alarm" "diplom-alarm-FF" {
  provider            = aws.reg_FF
  alarm_name          = "Monitoring CPU in FrankFurt"
  comparison_operator = "GreaterThanOrEqualToThreshold"
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

resource "aws_cloudwatch_metric_alarm" "disk-usage-FF" {
  provider            = aws.reg_FF
  alarm_name          = "Monitoring disk-usage in FrankFurt"
  comparison_operator = var.compare
  evaluation_periods  = "2"
  metric_name         = "LogicalDisk % Free Space"
  namespace           = "CWAgent"
  period              = "300"
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