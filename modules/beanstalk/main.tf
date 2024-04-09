data "aws_elastic_beanstalk_hosted_zone" "current" {}

# Setup key pair for ssh 
resource "aws_key_pair" "key_pair" {
  key_name   = "${var.app_name}-${var.app_env}-bean-key"
  public_key = file(var.key_directory)
}

resource "aws_elastic_beanstalk_application" "app_beanstalk" {
  name = "${var.app_name}-${var.app_env}"
}

data "aws_elastic_beanstalk_solution_stack" "multi_docker" {
  most_recent = true
  name_regex  = "^64bit Amazon Linux (.*) Multi-container Docker (.*)$"
}

resource "aws_elastic_beanstalk_environment" "app_beanstalk_env" {
  name                = "${var.app_name}-${var.app_env}-env"
  application         = aws_elastic_beanstalk_application.app_beanstalk.name
  solution_stack_name = data.aws_elastic_beanstalk_solution_stack.multi_docker.name

  # Set up auto-scaling instances
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "Minsize"
    value     = var.min_size
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "Maxsize"
    value     = var.max_size
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "DisableIMDSv1"
    value     = "true"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "EC2KeyName"
    value     = aws_key_pair.key_pair.id
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = var.ec2_role
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "SecurityGroups"
    value     = var.app_security_group_id
  }

  # Trigger the scaling
  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "MeasureName"
    value     = "CPUUtilization"
  }

  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "Unit"
    value     = "Percent"
  }

  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "LowerThreshold"
    value     = "40"
  }

  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "UpperThreshold"
    value     = "70"
  }

  # Set up EC2 instance
  setting {
    namespace = "aws:ec2:instances"
    name      = "InstanceTypes"
    value     = var.instances_type
  }

  # Set up VPC
  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = var.vpc_id
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBSecurityGroups"
    value     = var.elb_security_group_id
  }

  # Set up cloudwatch logs
  setting {
    namespace = "aws:elasticbeanstalk:cloudwatch:logs"
    name      = "StreamLogs"
    value     = "true"
  }

  setting {
    namespace = "aws:elasticbeanstalk:cloudwatch:logs"
    name      = "DeleteOnTerminate"
    value     = "true"
  }

  setting {
    namespace = "aws:elasticbeanstalk:cloudwatch:logs:health"
    name      = "HealthStreamingEnabled"
    value     = "true"
  }

  setting {
    namespace = "aws:elasticbeanstalk:cloudwatch:logs:health"
    name      = "DeleteOnTerminate"
    value     = "true"
  }

  # Set up environment
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "EnvironmentType"
    value     = "LoadBalanced"
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerType"
    value     = "application"
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "ServiceRole"
    value     = var.service_role
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "HealthCheckPath"
    value     = "/"
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "Port"
    value     = 80
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "Protocol"
    value     = "HTTP"
  }

  setting {
    namespace = "aws:elbv2:listener:default"
    name      = "DefaultProcess"
    value     = "HTTP"
  }

  # Set up environment variable
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "RAILS_ENV"
    value     = var.app_env
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "RDS_DB_NAME"
    value     = var.rds_db_name
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "RDS_USERNAME"
    value     = var.rds_username
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "RDS_PASSWORD"
    value     = var.rds_password
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "RDS_HOSTNAME"
    value     = var.rds_hostname
  }
}
