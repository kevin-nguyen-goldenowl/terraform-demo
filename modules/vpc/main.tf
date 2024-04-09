data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "app_beanstalk_sg" {
  name   = "${var.app_name}-${var.app_env}-beanstalk-sg"
  vpc_id = data.aws_vpc.default.id

  ingress {
    description     = "Allow access from load balancer"
    from_port       = var.container_port
    to_port         = var.container_port
    protocol        = "tcp"
    security_groups = [aws_security_group.app_beanstalk_elb_sg.id]
  }

  ingress {
    description = "Allow ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description      = "Allow all out traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.app_name}-${var.app_env}-beanstalk-sg"
  }
}

# Set up security group
resource "aws_security_group" "app_beanstalk_elb_sg" {
  name   = "${var.app_name}-${var.app_env}-beantalk-elb-sg"
  vpc_id = data.aws_vpc.default.id

  ingress {
    description      = "Allow http"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "Allow https"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    description      = "Allow all out traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.app_name}-${var.app_env}-beanstalk-elb-sg"
  }
}

resource "aws_security_group" "rds_sg" {
  name   = "${var.app_name}-${var.app_env}-rds-sg"
  vpc_id = data.aws_vpc.default.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.app_beanstalk_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.app_name}-${var.app_env}-rds-sg"
  }
}
