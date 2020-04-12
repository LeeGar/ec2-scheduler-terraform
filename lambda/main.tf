## Lambda
resource "aws_lambda_function" "ec2_scheduler_lambda" {
    filename = "../build/lambda.zip"
    function_name = "ec2-scheduler-lambda"
    handler = "app.handler"
    timeout = 15
    memory_size = 128
    runtime = "python3.7"
    role = var.lambda_role_arn
    source_code_hash = filebase64sha256("../build/lambda.zip")

    tags = {
        Name = "EC2 Lambda Scheduler"
    }
}

## Logs
resource "aws_cloudwatch_log_group" "lambda_cw_logs" {
  name              = "/aws/lambda/${aws_lambda_function.ec2_scheduler_lambda.function_name}"
  retention_in_days = 14
}

## Permissions
resource "aws_lambda_permission" "lambda_cloudwatch_start_trigger" {
  statement_id  = "AllowStartExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.ec2_scheduler_lambda.arn
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.lambda_event_start_rule.arn
}

resource "aws_lambda_permission" "lambda_cloudwatch_stop_trigger" {
  statement_id  = "AllowStopExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.ec2_scheduler_lambda.arn
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.lambda_event_stop_rule.arn
}

## CRON Rules
resource "aws_cloudwatch_event_rule" "lambda_event_start_rule" {
  name                = "8amDaily"
  description         = "EC2 start schedule"
  schedule_expression = "cron(0 15 ? * * *)"
}

resource "aws_cloudwatch_event_rule" "lambda_event_stop_rule" {
  name                = "10pmDaily"
  description         = "EC2 stop schedule"
  schedule_expression = "cron(0 5 ? * * *)"
}

## Triggers
resource "aws_cloudwatch_event_target" "lambda_cloudwatch_start_trigger" {
  target_id = "ec2-scheduler-lambda"
  input     = "{\"action\":\"start\",\"instanceid\":\"${var.aws_ec2_instance_id}\"}"
  rule      = aws_cloudwatch_event_rule.lambda_event_start_rule.name
  arn       = aws_lambda_function.ec2_scheduler_lambda.arn
}

resource "aws_cloudwatch_event_target" "lambda_cloudwatch_stop_trigger" {
  target_id = "ec2-scheduler-lambda"
  input     = "{\"action\":\"stop\",\"instanceid\":\"${var.aws_ec2_instance_id}\"}"
  rule      = aws_cloudwatch_event_rule.lambda_event_stop_rule.name
  arn       = aws_lambda_function.ec2_scheduler_lambda.arn
}
