provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
  token      = var.session_token
}
provider "archive" {}
data "archive_file" "zip" {
  type        = "zip"
  source_file = "lambda.py"
  output_path = "lambda.zip"
}
# data "aws_iam_policy_document" "policy" {
#   statement {
#     sid    = ""
#     effect = "Allow"
#     principals {
#       identifiers = ["lambda.amazonaws.com"]
#       type        = "Service"
#     }
#     actions = ["sts:AssumeRole"]
#   }
# }
# resource "aws_iam_role" "iam_for_lambda" {
#   name               = "iam_for_lambda_uda"
#   assume_role_policy = data.aws_iam_policy_document.policy.json
# }


resource "aws_iam_role" "lambda" {
  name = "lambda_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "lambda" {
  name       = "lambda_attachment"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  roles      = [aws_iam_role.lambda.name]
}

resource "aws_cloudwatch_log_group" "function_log_group" {
  name              = "/aws/lambda/lambda"
  retention_in_days = 14
  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_lambda_function" "lambda" {
  function_name    = "lambda"
  filename         = data.archive_file.zip.output_path
  source_code_hash = data.archive_file.zip.output_base64sha256
  role             = aws_iam_role.lambda.arn
  handler          = "lambda.lambda_handler"
  runtime          = var.runtime

  depends_on = [ aws_iam_role.lambda, aws_iam_policy_attachment.lambda ]
}
