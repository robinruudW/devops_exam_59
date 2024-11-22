output "sqs_queue_url" {
  value = aws_sqs_queue.image_processing_queue.url
  description = "The URL of the SQS queue"
}

output "lambda_function_name" {
  value = aws_lambda_function.image_processor.function_name
  description = "The name of the Lambda function"
}