#--------------------RDS-------------------#

resource "aws_db_instance" "gitbucket-mysql" {
  identifier              = "gitbucket-db"
  allocated_storage       = 10
  storage_encrypted       = false
  storage_type            = "gp2"
  engine                  = var.DB_engine
  engine_version          = var.mysql_engine_version
  instance_class          = var.mysql_instance_class
  multi_az                = false
  publicly_accessible     = true
  vpc_security_group_ids  = [var.mysql_vpc]
  backup_retention_period = 0
  name                    = var.mysql_db_name
  username                = var.mysql_username
  password                = data.aws_ssm_parameter.my_rds_password.value
  port                    = 3306
  skip_final_snapshot     = true
  apply_immediately       = true

  tags = var.default_tags
}

resource "random_string" "rds_password" {
  length           = 10
  special          = true
  override_special = "!#$&"
}
resource "aws_ssm_parameter" "rds_password" {
  name        = "gitbucket_rds"
  description = "Master Password for RDS MySQL"
  type        = "SecureString"
  value       = random_string.rds_password.result
  overwrite   = true
  lifecycle {
    ignore_changes = [value]
  }
  tags = var.default_tags
}
data "aws_ssm_parameter" "my_rds_password" {
  name       = "gitbucket_rds"
  depends_on = [aws_ssm_parameter.rds_password]
}