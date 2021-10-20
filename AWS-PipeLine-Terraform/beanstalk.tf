terraform {
  backend "remote" {
    organization = "pixel"

    workspaces {
      name = "gitbucket-actions"
    }
  }
}
provider "aws" {}
#--------------------BEANSTALK-------------------#

resource "aws_elastic_beanstalk_application" "gitbucket_app" {
  name        = "gitbucket-app"
  description = "GitBucket App"

  tags = var.default_tags
}

resource "aws_elastic_beanstalk_environment" "gitbucket_app_env" {
  name                = "gitbucket-env"
  application         = aws_elastic_beanstalk_application.gitbucket_app.name
  solution_stack_name = "64bit Amazon Linux 2 v4.2.6 running Tomcat 8.5 Corretto 8"
  tier                = "WebServer"


  setting {
    namespace = "aws:ec2:instances"
    name      = "InstanceTypes"
    value     = var.InstanceType
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "aws-elasticbeanstalk-ec2-role"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = var.InstanceType
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "EC2KeyName"
    value     = var.keypair
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = var.autoscale_min
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = var.autoscale_max
  }
  tags       = var.default_tags
  depends_on = [aws_db_instance.gitbucket-mysql]
}
