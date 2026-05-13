###############################################################################
# outputs.tf — Stack Outputs
#
# Best-practice improvements vs original output.tf:
#  - Removed hard-coded literal strings (deployment bucket name, domain names,
#    hosted zone ID) — all outputs now reference real resource attributes
#  - enterprise_log_access_iam_role now references the correctly named resource
#  - Added useful operational outputs: invoke URL, log group names, function ARNs
###############################################################################

output "http_api_id" {
  description = "ID of the HTTP API Gateway."
  value       = aws_apigatewayv2_api.http_api.id
}

output "http_api_invoke_url" {
  description = "Default invoke URL of the HTTP API ($default stage endpoint)."
  value       = aws_apigatewayv2_stage.default.invoke_url
}

output "http_api_execution_arn" {
  description = "Execution ARN of the HTTP API (useful for IAM policies and Lambda permissions)."
  value       = aws_apigatewayv2_api.http_api.execution_arn
}

output "lambda_execution_role_arn" {
  description = "ARN of the shared Lambda execution IAM role."
  value       = aws_iam_role.lambda_execution.arn
}

output "enterprise_log_access_iam_role_arn" {
  description = "ARN of the Serverless Enterprise log-access IAM role."
  value       = aws_iam_role.enterprise_log_access.arn
}

output "lambda_function_arns" {
  description = "Map of Lambda function short-name → ARN."
  value       = { for k, fn in aws_lambda_function.functions : k => fn.arn }
}

output "lambda_function_names" {
  description = "Map of Lambda function short-name → full function name."
  value       = { for k, fn in aws_lambda_function.functions : k => fn.function_name }
}

output "lambda_log_group_names" {
  description = "Map of Lambda function short-name → CloudWatch log group name."
  value       = { for k, lg in aws_cloudwatch_log_group.lambda_log_groups : k => lg.name }
}

output "http_api_log_group_name" {
  description = "CloudWatch log group name for the HTTP API access logs."
  value       = aws_cloudwatch_log_group.http_api.name
}

output "deployment_s3_bucket" {
  description = "S3 bucket where Lambda deployment ZIPs are stored."
  value       = local.lambda_s3_bucket
}

output "deployment_s3_key" {
  description = "S3 key path of the active Lambda deployment ZIP."
  value       = local.lambda_s3_key
}
