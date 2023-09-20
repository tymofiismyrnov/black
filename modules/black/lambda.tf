# Create an IAM role for the Lambda function
resource "aws_iam_role" "lambda_execution_role" {
  name = "lambda_execution_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# Attach an IAM policy to the Lambda execution role that allows creating EC2 instances
resource "aws_iam_policy" "ec2_creation_policy" {
  name        = "ec2_creation_policy"
  description = "Allows Lambda to create EC2 instances"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ec2:Describe*",
          "ec2:RunInstances",
          "ec2:CreateTags"
        ],
        Resource = "*"
      }
    ]
  })
}

# Attach the EC2 creation policy to the Lambda execution role
resource "aws_iam_policy_attachment" "ec2_creation_policy_attachment" {
  name       = "allow_create_ec2"
  policy_arn = aws_iam_policy.ec2_creation_policy.arn
  roles      = [aws_iam_role.lambda_execution_role.name]
}

# Create a Lambda function
resource "aws_lambda_function" "my_lambda" {
  function_name = "my_lambda_function"
  handler       = "index.lambda_handler"
  runtime       = "python3.11"
  role          = aws_iam_role.lambda_execution_role.arn
  timeout       = 10

  # Define your Lambda function code here
  filename = var.python_script_path

  source_code_hash = filebase64(var.python_script_path)

  environment {
    variables = {
      SUBNET_ID = aws_subnet.black_subnet.id
    }
  }
}

resource "aws_cloudwatch_event_rule" "lambda_schedule" {
  name                = "lambda_cron_trigger"
  description         = "Cron job trigger for Lambda function"
  schedule_expression = "cron(0 * * * ? *)"

}

resource "aws_cloudwatch_event_target" "sns" {
  rule = aws_cloudwatch_event_rule.lambda_schedule.name
  arn  = aws_lambda_function.my_lambda.arn
}


resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.my_lambda.function_name
  principal     = "events.amazonaws.com"

  source_arn = aws_cloudwatch_event_rule.lambda_schedule.arn
}
