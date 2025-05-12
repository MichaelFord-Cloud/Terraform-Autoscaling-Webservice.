# Create asg 
resource "aws_autoscaling_group" "asg" {
  vpc_zone_identifier  = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id, aws_subnet.private_subnet_3.id]
  name                 = "apache-asg"
  max_size             = 5
  min_size             = 2
  health_check_type    = "ELB"
  termination_policies = ["OldestInstance"]
  launch_template {
    id      = aws_launch_template.apache_lt.id
    version = "$Latest"
  }

  target_group_arns = [aws_alb_target_group.tg.arn]
}
