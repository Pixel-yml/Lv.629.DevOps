variable "default_tags" {
  description = "Tags to apply to all resources"
  type        = map
  default = {
    ita_group = "Lv-629"
    Owner     = "Danylo-Mikula"
    Demo      = "2"
  }
}
#--------------------BEANSTALK-------------------#
variable "sourceS3BucketName" {
  type        = string
  description = "S3 Bucket with Beanstalk Source File"
  default     = "gitbucketwar"
}
variable "sourceFilename" {
  type        = string
  description = "Beanstalk Source File Name"
  default     = "gitbucket.war"
}
variable "InstanceType" {
  type        = string
  description = "Beanstalk Instance Type"
  default     = "t2.micro"
}
variable "autoscale_max" {
  type        = number
  description = "Maximum Beanstalk instances To Launch"
  default     = 1
}
variable "autoscale_min" {
  type        = number
  description = "Minumum Beanstalk Snstances To Launch"
  default     = 1
}
variable "keypair" {
  type        = string
  description = "Beanstalk Instance Keypair"
  default     = "Frankfurt-dmikutc"
}
#--------------------CODEBUILD-------------------#
variable "project_srole" {
  type        = string
  description = "CodeBuild Project Service Role Arn"
  default     = "arn:aws:iam::536460581283:role/service-role/codebuild-gitbucket-proj-service-role"
}

#--------------------CODEPIPELINE-------------------#
variable "pipeline_srole" {
  type        = string
  description = "CodePipeLine Service Role Arn"
  default     = "arn:aws:iam::536460581283:role/service-role/AWSCodePipelineServiceRole-eu-central-1-gitbucket-pipeline"
}
variable "connection_arn" {
  type        = string
  description = "CodePipeline GitHub Connector Arn"
  default     = "arn:aws:codestar-connections:eu-central-1:536460581283:connection/cf0790fb-a5a1-4c00-88c0-f160b6dc18b3"
}
variable "repository_link" {
  type        = string
  description = "CodePipeline GitHub Repo Link"
  default     = "Pixel-yml/AWS-PipeLine-Terraform"
}
variable "artifact_store" {
  type        = string
  description = "CodePipeline Artifact S3 Bucket Store"
  default     = "aws_s3_bucket.codepipeline_s3.name"
}

#--------------------RDS-------------------#
variable "mysql_vpc" {
  type        = string
  description = "MySQL Vpc Security Group ID"
  default     = "sg-0d28b68e29517eeea"
}
variable "mysql_db_name" {
  type        = string
  description = "MySQL DB Name"
  default     = "gitbucket"
}
variable "DB_engine" {
  type        = string
  description = "DB Engine Type"
  default     = "mysql"
}
variable "mysql_engine_version" {
  type        = string
  description = "MySQL Engine Version"
  default     = "8.0.23"
}
variable "mysql_instance_class" {
  type        = string
  description = "MySQL Instance Class"
  default     = "db.t2.micro"
}
variable "mysql_username" {
  type        = string
  description = "MySQL Master Username"
  default     = "admin"
}