#--------------------BEANSTALK-------------------#
output "Beanstalk_ENV_id" {
  description = "ID of the Elastic Beanstalk Environment"
  value       = aws_elastic_beanstalk_environment.gitbucket_app_env.id
}
output "Beanstalk_ENV_dns_name" {
  description = "Fully Qualified DNS Name For The Beanstalk Environment"
  value       = aws_elastic_beanstalk_environment.gitbucket_app_env.cname
}
output "Beanstalk_ENV_endpoint_url" {
  description = "The URL to the Load Balancer for this Environment"
  value       = aws_elastic_beanstalk_environment.gitbucket_app_env.endpoint_url
}
output "Beanstalk_instances" {
  description = "Instances Used By Beanstalk"
  value       = aws_elastic_beanstalk_environment.gitbucket_app_env.instances
}
output "Beanstalk_load_balancers" {
  description = "Beanstalk Elastic Load Balancers"
  value       = aws_elastic_beanstalk_environment.gitbucket_app_env.load_balancers
}

#--------------------RDS-------------------#
output "db_instance_endpoint" {
  description = "The Database Connection Endpoint"
  value       = aws_db_instance.gitbucket-mysql.endpoint
}
output "db_master_username" {
  description = "The Master Username For The Database"
  value       = aws_db_instance.gitbucket-mysql.username
}
output "db_password" {
  description = "The Master Username Password"
  value = data.aws_ssm_parameter.my_rds_password.value
  sensitive = true
}
output "db_name" {
  description = "The Database Name"
  value       = aws_db_instance.gitbucket-mysql.name
}
output "db_instance_port" {
  description = "The Database Port"
  value       = aws_db_instance.gitbucket-mysql.port
}
output "db_instance_class" {
  description = "The Database Instance Class"
  value       = aws_db_instance.gitbucket-mysql.instance_class
}