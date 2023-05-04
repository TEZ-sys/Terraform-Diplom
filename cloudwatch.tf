resource "aws_cloudwatch_metric_alarm" "diplom-alarm" {
  alarm_name                = "diplom-alarm-test"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "40"
  alarm_description         = "This metric monitors ec2 cpu utilization"
  insufficient_data_actions = []

  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.diplom_asg.name}"
  }
}

resource "aws_cloudwatch_metric_alarm" "diplom-alarm2" {
  provider = aws.reg_FF
  alarm_name                = "diplom-alarm-test"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "40"
  alarm_description         = "This metric monitors ec2 cpu utilization"
  insufficient_data_actions = []

  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.diplom_asg2.name}"
  }
}
