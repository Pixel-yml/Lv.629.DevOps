#--------------------CODEPIPELINE-------------------#

resource "aws_codepipeline" "codepipeline" {
  name     = "gitbucket-pipeline"
  role_arn = var.pipeline_srole

  artifact_store {
    location = aws_s3_bucket.codepipeline_s3.bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        ConnectionArn        = var.connection_arn
        FullRepositoryId     = var.repository_link
        BranchName           = "main"
        OutputArtifactFormat = "CODEBUILD_CLONE_REF"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"
      run_order        = "1"

      configuration = {
        ProjectName   = "gitbucket-proj"
        PrimarySource = "source_output"
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "ElasticBeanstalk"
      input_artifacts = ["build_output"]
      version         = "1"

      configuration = {
        ApplicationName = "gitbucket-app"
        EnvironmentName = "gitbucket-env"
      }
    }
  }
  tags       = var.default_tags
  depends_on = [aws_elastic_beanstalk_environment.gitbucket_app_env, aws_codebuild_project.gitbucket-proj]
}

resource "aws_s3_bucket" "codepipeline_s3" {
  bucket        = "codepipeline-artifacts-lv629"
  acl           = "private"
  force_destroy = true

  tags = var.default_tags
}
