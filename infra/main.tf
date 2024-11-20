terraform {
  required_version = ">= 1.9.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.74.0"
    }
  }
  backend "s3" {
    bucket         = "pgr301-2024-terraform-state"
    key            = "59/new-terraform.tfstate"
    region         = "eu-west-1"
  }
}

provider "aws" {
  region = "eu-west-1"
}


resource "aws_sqs_queue" "image_processing_queue" {
  name                        = "image_processing_queue_59"
  visibility_timeout_seconds  = 30
  message_retention_seconds   = 86400
}


resource "aws_lambda_function" "image_processor" {
  function_name    = "image_processor"
  runtime          = "python3.9"
  role             = var.my_role_arn  
  handler          = "lambda_sqs.lambda_handler"
  timeout          = 30
  filename         = "${path.module}/lambda/lambda_sqs.zip"
  environment {
    variables = {
      BUCKET_NAME = "pgr301-couch-explorers"
    }
  }
}


resource "aws_lambda_event_source_mapping" "sqs_event_mapping" {
  event_source_arn = aws_sqs_queue.image_processing_queue.arn
  function_name    = aws_lambda_function.image_processor.arn
  batch_size       = 10
  enabled          = true
}

