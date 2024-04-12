app_name             = "ideas-api"
app_env              = "staging"
sshkey_dir           = "~/.ssh/idea-eb-prod.pub"
instance_port        = 80
min_size             = 1
max_size             = 2
ec2_role             = "aws-elasticbeanstalk-ec2-role "
service_role         = "aws-elasticbeanstalk-service-role"
db_allocated_storage = "20"
db_engine            = "postgres"
db_engine_version    = "14.5"
db_instance_class    = "db.t3.micro"
db_password          = "123Admin!123Admin!123Admin!"
db_username          = "postgres"
