#--------------------CODEBUILD-------------------#

resource "aws_codebuild_project" "gitbucket-proj" {
  name         = "gitbucket-proj"
  description  = "gitbucket_project"
  service_role = var.project_srole

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:5.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }
  source {
    type = "CODEPIPELINE"
  }

  logs_config {
    cloudwatch_logs {
      status = "DISABLED"
    }

    s3_logs {
      encryption_disabled = "true"
      status              = "ENABLED"
      location            = "codebuild-logs-lv629/build-logs"
    }
  }
  depends_on = [aws_s3_bucket.codebuild_logs, aws_elastic_beanstalk_environment.gitbucket_app_env]
  tags       = var.default_tags
}

resource "aws_s3_bucket" "codebuild_logs" {
  bucket        = "codebuild-logs-lv629"
  acl           = "private"
  force_destroy = true

  tags = var.default_tags
}
