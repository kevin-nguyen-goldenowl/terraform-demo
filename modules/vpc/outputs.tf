output "vpc" {
  value = data.aws_vpc.default
}

output "beanstalk_sg" {
  value = aws_security_group.app_beanstalk_sg
}

output "elb_sg" {
  value = aws_security_group.app_beanstalk_elb_sg
}

output "rds_sg" {
  value = aws_security_group.rds_sg
}
