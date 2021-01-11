resource "aws_autoscaling_policy" "app_autoscaling" {
  name                   = "${var.app_prefix}-as-policy"
  scaling_adjustment     = 4
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = module.asg.this_autoscaling_group_name
}

resource "aws_cloudwatch_metric_alarm" "cloudwatch_metric" {
  alarm_name          = "${var.app_prefix}-metric"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "80"

  dimensions = {
    AutoScalingGroupName = module.asg.this_autoscaling_group_name
  }

  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = [aws_autoscaling_policy.app_autoscaling.arn]
}
