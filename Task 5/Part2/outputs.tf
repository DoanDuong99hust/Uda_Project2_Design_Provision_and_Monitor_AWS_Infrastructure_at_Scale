output "lambda_function_id" {
  description = "The id of the Lambda Function"
  value       = aws_lambda_function.lambda.id
}

output "lambda_function_architectures" {
  description = "The id of the Lambda Function"
  value       = aws_lambda_function.lambda.architectures
}

output "lambda_function_version" {
  description = "Latest published version of Lambda Function"
  value       = aws_lambda_function.lambda.version
}