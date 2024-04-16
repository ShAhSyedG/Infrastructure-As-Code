output "serverless_deployment_bucket_name" {
  value = "pk.jobapp.dev.us-east-1"
}

output "enterprise_log_access_iam_role" {
  value = aws_iam_role.enterprise_log_access_iam_role.arn
}

output "http_api_id" {
  description = "Id of the HTTP API"
  value = aws_apigatewayv2_api.http_api.id
}

output "http_api_url" {
  description = "URL of the HTTP API"
  value = join("", ["https://", aws_apigatewayv2_api.http_api.id, ".execute-api.", data.aws_region.current.name, ".", data.aws_partition.current.dns_suffix])
}

output "domain_name_http" {
  value = "api.dev.jobapp.pk"
}

output "distribution_domain_name_http" {
  value = "d-by5j550xaa.execute-api.us-east-1.amazonaws.com"
}

output "hosted_zone_id_http" {
  value = "Z1UJRXOUMOOFQ8"
}