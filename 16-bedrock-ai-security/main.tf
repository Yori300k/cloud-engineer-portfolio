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

data "aws_iam_policy_document" "trust" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ai_gateway" {
  name               = "bedrock-gateway-role"
  assume_role_policy = data.aws_iam_policy_document.trust.json
}

data "aws_iam_policy_document" "bedrock_scoped" {
  statement {
    actions = ["bedrock:InvokeModel", "bedrock:Converse"]
    resources = [
      "arn:aws:bedrock:*::foundation-model/amazon.nova-lite-v1:0",
      "arn:aws:bedrock:us-east-1:344838028727:inference-profile/us.amazon.nova-lite-v1:0"
    ]
  }
}

resource "aws_iam_role_policy" "bedrock_scoped" {
  name   = "bedrock-one-model-only"
  role   = aws_iam_role.ai_gateway.id
  policy = data.aws_iam_policy_document.bedrock_scoped.json
}

resource "aws_iam_role_policy_attachment" "logs" {
  role       = aws_iam_role.ai_gateway.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

data "archive_file" "zip" {
  type        = "zip"
  source_file = "${path.module}/lambda_function.py"
  output_path = "${path.module}/lambda_function.zip"
}

resource "aws_lambda_function" "ai_gateway" {
  function_name    = "bedrock-gateway"
  role             = aws_iam_role.ai_gateway.arn
  runtime          = "python3.12"
  handler          = "lambda_function.handler"
  filename         = data.archive_file.zip.output_path
  source_code_hash = data.archive_file.zip.output_base64sha256
  timeout          = 30
}
