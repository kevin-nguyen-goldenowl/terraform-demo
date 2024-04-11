output "output_url" {
  value = aws_elastic_beanstalk_environment.app_beanstalk_env.endpoint_url
}

output "cname" {
  value = aws_elastic_beanstalk_environment.app_beanstalk_env.cname
}
