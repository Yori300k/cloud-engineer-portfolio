terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_dynamodb_table" "links" {
  name         = "url-shortener-links"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "short_code"

  attribute {
    name = "short_code"
    type = "S"
  }

  tags = {
    Project = "13-serverless"
  }
}

data "aws_iam_policy_document" "lambda_trust" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "shortener_lambda" {
  name               = "url-shortener-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_trust.json
}

data "aws_iam_policy_document" "table_access" {
  statement {
    actions   = ["dynamodb:PutItem", "dynamodb:GetItem"]
    resources = [aws_dynamodb_table.links.arn]
  }
}

resource "aws_iam_role_policy" "table_access" {
  name   = "url-shortener-table-access"
  role   = aws_iam_role.shortener_lambda.id
  policy = data.aws_iam_policy_document.table_access.json
}

resource "aws_iam_role_policy_attachment" "basic_logs" {
  role       = aws_iam_role.shortener_lambda.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/lambda_function.py"
  output_path = "${path.module}/lambda_function.zip"
}

resource "aws_lambda_function" "shortener" {
  function_name    = "url-shortener"
  role             = aws_iam_role.shortener_lambda.arn
  runtime          = "python3.12"
  handler          = "lambda_function.handler"
  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.links.name
    }
  }
}

resource "aws_apigatewayv2_api" "shortener" {
  name          = "url-shortener-api"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "lambda" {
  api_id                 = aws_apigatewayv2_api.shortener.id
  integration_type       = "AWS_PROXY"
  integration_uri        = aws_lambda_function.shortener.invoke_arn
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "post_links" {
  api_id    = aws_apigatewayv2_api.shortener.id
  route_key = "POST /links"
  target    = "integrations/${aws_apigatewayv2_integration.lambda.id}"
}

resource "aws_apigatewayv2_route" "get_code" {
  api_id    = aws_apigatewayv2_api.shortener.id
  route_key = "GET /{code}"
  target    = "integrations/${aws_apigatewayv2_integration.lambda.id}"
}

resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.shortener.id
  name        = "$default"
  auto_deploy = true
}


 resource "aws_lambda_permission" "apigw_invoke" {
   statement_id  = "AllowAPIGatewayInvoke"
   action        = "lambda:InvokeFunction"
   function_name = aws_lambda_function.shortener.function_name
   principal     = "apigateway.amazonaws.com"
   source_arn    = "${aws_apigatewayv2_api.shortener.execution_arn}/*/*"
 }

output "api_url" {
  value = aws_apigatewayv2_api.shortener.api_endpoint
}
