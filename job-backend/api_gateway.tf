resource "aws_apigatewayv2_api" "http_api" {
  name = "dev-backend"
  protocol_type = var.protocol
}
resource "aws_apigatewayv2_route_settings" "verify_dashemail_route_settings" {
  api_id    = aws_apigatewayv2_api.http_api.id
  route_key = aws_apigatewayv2_route.http_api_route_get_v1_verify_dashemail.route_key
  cors_configuration = {
    AllowHeaders = [
      "Content-Type",
      "X-Amz-Date",
      "Authorization",
      "X-Api-Key",
      "X-Amz-Security-Token",
      "X-Amz-User-Agent",
      "X-Amzn-Trace-Id"
    ]
    AllowMethods = [
      "OPTIONS",
      "GET",
      "POST",
      "DELETE",
      "PUT",
      "PATCH"
    ]
    AllowOrigins = [
      "*"
    ]
  }
}


resource "aws_apigatewayv2_stage" "http_api_stage" {
  api_id = aws_apigatewayv2_api.http_api.id
  name = "$default"
  auto_deploy = true
  default_route_settings {
    detailed_metrics_enabled = false
  }
  #access_log_settings {
  #  destination_arn = aws_lb_target_group.http_api_log_group.arn
  #  format = "{"requestTime":"$context.requestTime","requestId":"$context.requestId","apiId":"$context.apiId","resourcePath":"$context.routeKey","path":"$context.path","httpMethod":"$context.httpMethod","stage":"$context.stage","status":"$context.status","integrationStatus":"$context.integrationStatus","integrationLatency":"$context.integrationLatency","responseLatency":"$context.responseLatency","responseLength":"$context.responseLength","errorMessage":"$context.error.message","format":"SLS_HTTP_API_LOG","version":"1.0.0"}"
  #}
  access_log_settings {
    destination_arn = aws_lb_target_group.http_api_log_group.arn
    format = "{\"requestTime\":\"$context.requestTime\",\"requestId\":\"$context.requestId\",\"apiId\":\"$context.apiId\",\"resourcePath\":\"$context.routeKey\",\"path\":\"$context.path\",\"httpMethod\":\"$context.httpMethod\",\"stage\":\"$context.stage\",\"status\":\"$context.status\",\"integrationStatus\":\"$context.integrationStatus\",\"integrationLatency\":\"$context.integrationLatency\",\"responseLatency\":\"$context.responseLatency\",\"responseLength\":\"$context.responseLength\",\"errorMessage\":\"$context.error.message\",\"format\":\"SLS_HTTP_API_LOG\",\"version\":\"1.0.0\"}"
}
}

resource "aws_lambda_permission" "verify_email_lambda_permission_http_api" {
  function_name = aws_lambda_function.verify_email_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_verify_email" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.verify_email_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_get_v1_verify_dashemail" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "GET /v1/verify-email"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_verify_email.id])
}

resource "aws_lambda_permission" "validate_reset_password_lambda_permission_http_api" {
  function_name = aws_lambda_function.validate_reset_password_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_validate_reset_password" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.validate_reset_password_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_get_v1_validate_dashreset_dashpassword" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "GET /v1/validate-reset-password"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_validate_reset_password.id])
}

resource "aws_lambda_permission" "reset_password_lambda_permission_http_api" {
  function_name = aws_lambda_function.reset_password_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_reset_password" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.reset_password_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_post_v1_reset_dashpassword" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "POST /v1/reset-password"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_reset_password.id])
}

resource "aws_lambda_permission" "update_email_lambda_permission_http_api" {
  function_name = aws_lambda_function.update_email_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_update_email" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.update_email_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_get_v1_update_dashemail" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "GET /v1/update-email"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_update_email.id])
}

resource "aws_lambda_permission" "sign_up_lambda_permission_http_api" {
  function_name = aws_lambda_function.sign_up_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_sign_up" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.sign_up_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_post_v1_auth_sign_dashup" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "POST /v1/auth/sign-up"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_sign_up.id])
}

resource "aws_lambda_permission" "resend_email_lambda_permission_http_api" {
  function_name = aws_lambda_function.resend_email_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_resend_email" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.resend_email_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_post_v1_auth_resend_dashemail" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "POST /v1/auth/resend-email"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_resend_email.id])
}

resource "aws_lambda_permission" "sign_in_lambda_permission_http_api" {
  function_name = aws_lambda_function.sign_in_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_sign_in" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.sign_in_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_post_v1_auth_sign_dashin" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "POST /v1/auth/sign-in"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_sign_in.id])
}

resource "aws_lambda_permission" "login_with_mera_id_lambda_permission_http_api" {
  function_name = aws_lambda_function.login_with_mera_id_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_login_with_mera_id" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.login_with_mera_id_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_post_v1_auth_meraid_dashsign_dashin" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "POST /v1/auth/meraid-sign-in"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_login_with_mera_id.id])
}

resource "aws_lambda_permission" "collect_mera_id_status_lambda_permission_http_api" {
  function_name = aws_lambda_function.collect_mera_id_status_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_collect_mera_id_status" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.collect_mera_id_status_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_post_v1_auth_meraid_dashcollect" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "POST /v1/auth/meraid-collect"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_collect_mera_id_status.id])
}

resource "aws_lambda_permission" "request_password_reset_lambda_permission_http_api" {
  function_name = aws_lambda_function.request_password_reset_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_request_password_reset" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.request_password_reset_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_post_v1_auth_request_dashreset_dashpassword" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "POST /v1/auth/request-reset-password"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_request_password_reset.id])
}

resource "aws_lambda_permission" "get_user_lambda_permission_http_api" {
  function_name = aws_lambda_function.get_user_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_get_user" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.get_user_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_get_v1_auth_init" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "GET /v1/auth/init"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_get_user.id])
}

resource "aws_lambda_permission" "document_upload_lambda_permission_http_api" {
  function_name = aws_lambda_function.document_upload_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_document_upload" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.document_upload_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_post_v1_user_userid_var_upload_dashdocument" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "POST /v1/user/{userId}/upload-document"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_document_upload.id])
}

resource "aws_lambda_permission" "resume_personal_info_lambda_permission_http_api" {
  function_name = aws_lambda_function.resume_personal_info_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_resume_personal_info" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.resume_personal_info_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_post_v1_user_userid_var_resume_dashbuilder_personal_dashinfo" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "POST /v1/user/{userId}/resume-builder/personal-info"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_resume_personal_info.id])
}

resource "aws_lambda_permission" "resume_continuation_lambda_permission_http_api" {
  function_name = aws_lambda_function.resume_continuation_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_resume_continuation" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.resume_continuation_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_post_v1_user_userid_var_resume_dashbuilder_resume_resumeid_var_any_var" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "POST /v1/user/{userId}/resume-builder/resume/{resumeId}/{ANY+}"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_resume_continuation.id])
}

resource "aws_lambda_permission" "job_details_lambda_permission_http_api" {
  function_name = aws_lambda_function.job_details_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_job_details" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.job_details_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_get_v1_user_userid_var_jobs_jobid_var" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "GET /v1/user/{userId}/jobs/{jobId}"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_job_details.id])
}

resource "aws_lambda_permission" "apply_for_job_lambda_permission_http_api" {
  function_name = aws_lambda_function.apply_for_job_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_apply_for_job" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.apply_for_job_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_post_v1_user_userid_var_jobs_jobid_var_apply" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "POST /v1/user/{userId}/jobs/{jobId}/apply"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_apply_for_job.id])
}

resource "aws_lambda_permission" "apply_via_mera_id_lambda_permission_http_api" {
  function_name = aws_lambda_function.apply_via_mera_id_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_apply_via_mera_id" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.apply_via_mera_id_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_post_v1_user_userid_var_jobs_jobid_var_apply_dashwith_dashmeraid" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "POST /v1/user/{userId}/jobs/{jobId}/apply-with-meraid"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_apply_via_mera_id.id])
}

resource "aws_lambda_permission" "apply_via_mera_id_status_lambda_permission_http_api" {
  function_name = aws_lambda_function.apply_via_mera_id_status_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_apply_via_mera_id_status" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.apply_via_mera_id_status_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_post_v1_user_userid_var_apply_dashwith_dashmeraid_dashstatus" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "POST /v1/user/{userId}/apply-with-meraid-status"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_apply_via_mera_id_status.id])
}

resource "aws_lambda_permission" "get_resume_lambda_permission_http_api" {
  function_name = aws_lambda_function.get_resume_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_get_resume" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.get_resume_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_get_v1_user_userid_var_resume_resumeid_var" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "GET /v1/user/{userId}/resume/{resumeId+}"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_get_resume.id])
}

resource "aws_lambda_permission" "get_job_app_hist_lambda_permission_http_api" {
  function_name = aws_lambda_function.get_job_app_hist_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_get_job_app_hist" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.get_job_app_hist_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_get_v1_user_userid_var_jobs_history" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "GET /v1/user/{userId}/jobs/history"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_get_job_app_hist.id])
}

resource "aws_lambda_permission" "get_job_app_detail_lambda_permission_http_api" {
  function_name = aws_lambda_function.get_job_app_detail_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_get_job_app_detail" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.get_job_app_detail_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_get_v1_user_userid_var_apps_jobid_var" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "GET /v1/user/{userId}/apps/{jobId}"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_get_job_app_detail.id])
}

resource "aws_lambda_permission" "withdraw_job_app_lambda_permission_http_api" {
  function_name = aws_lambda_function.withdraw_job_app_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_withdraw_job_app" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.withdraw_job_app_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_post_v1_user_userid_var_apps_jobid_var_withdraw" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "POST /v1/user/{userId}/apps/{jobId}/withdraw"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_withdraw_job_app.id])
}

resource "aws_lambda_permission" "get_jobs_lambda_permission_http_api" {
  function_name = aws_lambda_function.get_jobs_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_get_jobs" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.get_jobs_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_get_v1_user_userid_var_jobs" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "GET /v1/user/{userId}/jobs"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_get_jobs.id])
}

resource "aws_lambda_permission" "get_job_applications_lambda_permission_http_api" {
  function_name = aws_lambda_function.get_job_applications_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_get_job_applications" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.get_job_applications_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_get_v1_user_userid_var_jobs_jobid_var_applications" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "GET /v1/user/{userId}/jobs/{jobId}/applications"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_get_job_applications.id])
}

resource "aws_lambda_permission" "ack_csv_upload_lambda_permission_http_api" {
  function_name = aws_lambda_function.ack_csv_upload_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_ack_csv_upload" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.ack_csv_upload_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_post_v1_user_userid_var_jobs_jobid_var_acknowledge_dashcsv_dashupload" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "POST /v1/user/{userId}/jobs/{jobId}/acknowledge-csv-upload"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_ack_csv_upload.id])
}

resource "aws_lambda_permission" "get_candidate_groups_lambda_permission_http_api" {
  function_name = aws_lambda_function.get_candidate_groups_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_get_candidate_groups" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.get_candidate_groups_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_get_v1_user_userid_var_jobs_jobid_var_candidate_dashgroups" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "GET /v1/user/{userId}/jobs/{jobId}/candidate-groups"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_get_candidate_groups.id])
}

resource "aws_lambda_permission" "notify_job_candidates_lambda_permission_http_api" {
  function_name = aws_lambda_function.notify_job_candidates_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_notify_job_candidates" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.notify_job_candidates_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_post_v1_user_userid_var_jobs_jobid_var_candidate_dashgroups_groupid_var_notify" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "POST /v1/user/{userId}/jobs/{jobId}/candidate-groups/{groupId}/notify"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_notify_job_candidates.id])
}

resource "aws_lambda_permission" "get_applicant_group_file_lambda_permission_http_api" {
  function_name = aws_lambda_function.get_applicant_group_file_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_get_applicant_group_file" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.get_applicant_group_file_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_get_v1_user_userid_var_jobs_jobid_var_candidate_dashgroups_groupid_var_download" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "GET /v1/user/{userId}/jobs/{jobId}/candidate-groups/{groupId}/download"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_get_applicant_group_file.id])
}

resource "aws_lambda_permission" "get_notifications_lambda_permission_http_api" {
  function_name = aws_lambda_function.get_notifications_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_get_notifications" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.get_notifications_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_get_v1_user_userid_var_notifications" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "GET /v1/user/{userId}/notifications"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_get_notifications.id])
}

resource "aws_lambda_permission" "delete_candidate_group_lambda_permission_http_api" {
  function_name = aws_lambda_function.delete_candidate_group_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_delete_candidate_group" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.delete_candidate_group_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_delete_v1_user_userid_var_jobs_jobid_var_candidate_dashgroups_groupid_var" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "DELETE /v1/user/{userId}/jobs/{jobId}/candidate-groups/{groupId}"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_delete_candidate_group.id])
}

resource "aws_lambda_permission" "update_profile_lambda_permission_http_api" {
  function_name = aws_lambda_function.update_profile_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_update_profile" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.update_profile_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_post_v1_user_userid_var_update" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "POST /v1/user/{userId}/update"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_update_profile.id])
}

resource "aws_lambda_permission" "profile_lambda_permission_http_api" {
  function_name = aws_lambda_function.profile_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_profile" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.profile_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_get_v1_user_userid_var" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "GET /v1/user/{userId}"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_profile.id])
}

resource "aws_lambda_permission" "create_job_lambda_permission_http_api" {
  function_name = aws_lambda_function.create_job_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_create_job" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.create_job_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_post_v1_jobs" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "POST /v1/jobs"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_create_job.id])
}

resource "aws_lambda_permission" "update_job_lambda_permission_http_api" {
  function_name = aws_lambda_function.update_job_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_update_job" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.update_job_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_put_v1_jobs_jobid_var" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "PUT /v1/jobs/{jobId}"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_update_job.id])
}

resource "aws_lambda_permission" "delete_job_lambda_permission_http_api" {
  function_name = aws_lambda_function.delete_job_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_delete_job" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.delete_job_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_delete_v1_jobs_jobid_var" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "DELETE /v1/jobs/{jobId}"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_delete_job.id])
}

resource "aws_lambda_permission" "expire_job_lambda_permission_http_api" {
  function_name = aws_lambda_function.expire_job_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_expire_job" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.expire_job_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_patch_v1_user_userid_var_jobs_jobid_var_expire" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "PATCH /v1/user/{userId}/jobs/{jobId}/expire"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_expire_job.id])
}

resource "aws_lambda_permission" "create_org_lambda_permission_http_api" {
  function_name = aws_lambda_function.create_org_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_create_org" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.create_org_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_post_v1_org" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "POST /v1/org"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_create_org.id])
}

resource "aws_lambda_permission" "update_org_lambda_permission_http_api" {
  function_name = aws_lambda_function.update_org_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_update_org" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.update_org_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_put_v1_org_orgid_var" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "PUT /v1/org/{orgId}"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_update_org.id])
}

resource "aws_lambda_permission" "get_orgs_lambda_permission_http_api" {
  function_name = aws_lambda_function.get_orgs_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_get_orgs" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.get_orgs_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_get_v1_orgs" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "GET /v1/orgs"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_get_orgs.id])
}

resource "aws_lambda_permission" "delete_org_lambda_permission_http_api" {
  function_name = aws_lambda_function.delete_org_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_delete_org" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.delete_org_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_delete_v1_org_orgid_var" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "DELETE /v1/org/{orgId}"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_delete_org.id])
}

resource "aws_lambda_permission" "org_details_lambda_permission_http_api" {
  function_name = aws_lambda_function.org_details_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_org_details" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.org_details_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_get_v1_orgs_orgid_var" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "GET /v1/orgs/{orgId}"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_org_details.id])
}

resource "aws_lambda_permission" "create_org_role_lambda_permission_http_api" {
  function_name = aws_lambda_function.create_org_role_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_create_org_role" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.create_org_role_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_post_v1_orgs_orgid_var_roles" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "POST /v1/orgs/{orgId}/roles"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_create_org_role.id])
}

resource "aws_lambda_permission" "update_org_role_lambda_permission_http_api" {
  function_name = aws_lambda_function.update_org_role_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_update_org_role" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.update_org_role_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_patch_v1_orgs_orgid_var_roles_roleid_var" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "PATCH /v1/orgs/{orgId}/roles/{roleId}"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_update_org_role.id])
}

resource "aws_lambda_permission" "delete_org_role_lambda_permission_http_api" {
  function_name = aws_lambda_function.delete_org_role_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_delete_org_role" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.delete_org_role_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_delete_v1_orgs_orgid_var_roles_roleid_var" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "DELETE /v1/orgs/{orgId}/roles/{roleId}"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_delete_org_role.id])
}

resource "aws_lambda_permission" "get_org_roles_lambda_permission_http_api" {
  function_name = aws_lambda_function.get_org_roles_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_get_org_roles" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.get_org_roles_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_get_v1_orgs_orgid_var_roles" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "GET /v1/orgs/{orgId}/roles"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_get_org_roles.id])
}

resource "aws_lambda_permission" "get_org_members_lambda_permission_http_api" {
  function_name = aws_lambda_function.get_org_members_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_get_org_members" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.get_org_members_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_get_v1_orgs_orgid_var_members" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "GET /v1/orgs/{orgId}/members"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_get_org_members.id])
}

resource "aws_lambda_permission" "delete_org_member_lambda_permission_http_api" {
  function_name = aws_lambda_function.delete_org_member_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_delete_org_member" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.delete_org_member_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_delete_v1_orgs_orgid_var_members_memberid_var" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "DELETE /v1/orgs/{orgId}/members/{memberId}"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_delete_org_member.id])
}

resource "aws_lambda_permission" "create_org_member_lambda_permission_http_api" {
  function_name = aws_lambda_function.create_org_member_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_create_org_member" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.create_org_member_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_post_v1_orgs_orgid_var_members" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "POST /v1/orgs/{orgId}/members"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_create_org_member.id])
}

resource "aws_lambda_permission" "update_org_member_lambda_permission_http_api" {
  function_name = aws_lambda_function.update_org_member_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_update_org_member" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.update_org_member_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_patch_v1_orgs_orgid_var_members_memberid_var" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "PATCH /v1/orgs/{orgId}/members/{memberId}"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_update_org_member.id])
}

resource "aws_lambda_permission" "create_org_pipeline_lambda_permission_http_api" {
  function_name = aws_lambda_function.create_org_pipeline_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_create_org_pipeline" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.create_org_pipeline_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_post_v1_orgs_orgid_var_pipelines" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "POST /v1/orgs/{orgId}/pipelines"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_create_org_pipeline.id])
}

resource "aws_lambda_permission" "get_org_pipeline_lambda_permission_http_api" {
  function_name = aws_lambda_function.get_org_pipeline_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_get_org_pipeline" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.get_org_pipeline_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_get_v1_orgs_orgid_var_pipelines" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "GET /v1/orgs/{orgId}/pipelines"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_get_org_pipeline.id])
}

resource "aws_lambda_permission" "delete_org_pipeline_lambda_permission_http_api" {
  function_name = aws_lambda_function.delete_org_pipeline_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_delete_org_pipeline" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.delete_org_pipeline_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_delete_v1_orgs_orgid_var_pipelines_pipelineid_var" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "DELETE /v1/orgs/{orgId}/pipelines/{pipelineId}"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_delete_org_pipeline.id])
}

resource "aws_lambda_permission" "update_org_pipeline_lambda_permission_http_api" {
  function_name = aws_lambda_function.update_org_pipeline_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_update_org_pipeline" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.update_org_pipeline_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_put_v1_orgs_orgid_var_pipelines_pipelineid_var" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "PUT /v1/orgs/{orgId}/pipelines/{pipelineId}"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_update_org_pipeline.id])
}

resource "aws_lambda_permission" "get_org_jobs_lambda_permission_http_api" {
  function_name = aws_lambda_function.get_org_jobs_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_get_org_jobs" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.get_org_jobs_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_get_v1_orgs_orgid_var_jobs" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "GET /v1/orgs/{orgId}/jobs"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_get_org_jobs.id])
}

resource "aws_lambda_permission" "delete_org_job_lambda_permission_http_api" {
  function_name = aws_lambda_function.delete_org_job_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_delete_org_job" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.delete_org_job_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_delete_v1_orgs_orgid_var_jobs_jobid_var" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "DELETE /v1/orgs/{orgId}/jobs/{jobId}"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_delete_org_job.id])
}

resource "aws_lambda_permission" "create_org_job_lambda_permission_http_api" {
  function_name = aws_lambda_function.create_org_job_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_create_org_job" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.create_org_job_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_post_v1_orgs_orgid_var_jobs" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "POST /v1/orgs/{orgId}/jobs"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_create_org_job.id])
}

resource "aws_lambda_permission" "update_org_info_lambda_permission_http_api" {
  function_name = aws_lambda_function.update_org_info_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_update_org_info" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.update_org_info_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_patch_v1_orgs_orgid_var" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "PATCH /v1/orgs/{orgId}"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_update_org_info.id])
}

resource "aws_lambda_permission" "update_org_job_lambda_permission_http_api" {
  function_name = aws_lambda_function.update_org_job_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_update_org_job" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.update_org_job_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_put_v1_orgs_orgid_var_jobs_jobid_var" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "PUT /v1/orgs/{orgId}/jobs/{jobId}"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_update_org_job.id])
}

resource "aws_lambda_permission" "get_job_info_lambda_permission_http_api" {
  function_name = aws_lambda_function.get_job_info_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_get_job_info" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.get_job_info_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_get_v1_orgs_orgid_var_jobs_jobid_var" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "GET /v1/orgs/{orgId}/jobs/{jobId}"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_get_job_info.id])
}

resource "aws_lambda_permission" "get_job_apps_lambda_permission_http_api" {
  function_name = aws_lambda_function.get_job_apps_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_get_job_apps" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.get_job_apps_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_get_v1_orgs_orgid_var_jobs_jobid_var_apps" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "GET /v1/orgs/{orgId}/jobs/{jobId}/apps"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_get_job_apps.id])
}

resource "aws_lambda_permission" "forward_job_app_lambda_permission_http_api" {
  function_name = aws_lambda_function.forward_job_app_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_forward_job_app" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.forward_job_app_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_post_v1_orgs_orgid_var_jobs_jobid_var_apps_appid_var_forward" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "POST /v1/orgs/{orgId}/jobs/{jobId}/apps/{appId}/forward"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_forward_job_app.id])
}

resource "aws_lambda_permission" "post_job_app_score_lambda_permission_http_api" {
  function_name = aws_lambda_function.post_job_app_score_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_post_job_app_score" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.post_job_app_score_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_post_v1_orgs_orgid_var_jobs_jobid_var_apps_appid_var_score" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "POST /v1/orgs/{orgId}/jobs/{jobId}/apps/{appId}/score"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_post_job_app_score.id])
}

resource "aws_lambda_permission" "post_job_app_comment_lambda_permission_http_api" {
  function_name = aws_lambda_function.post_job_app_comment_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_post_job_app_comment" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.post_job_app_comment_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_post_v1_orgs_orgid_var_jobs_jobid_var_apps_appid_var_comments" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "POST /v1/orgs/{orgId}/jobs/{jobId}/apps/{appId}/comments"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_post_job_app_comment.id])
}

resource "aws_lambda_permission" "drop_job_app_lambda_permission_http_api" {
  function_name = aws_lambda_function.drop_job_app_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_drop_job_app" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.drop_job_app_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_post_v1_orgs_orgid_var_jobs_jobid_var_apps_appid_var_drop" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "POST /v1/orgs/{orgId}/jobs/{jobId}/apps/{appId}/drop"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_drop_job_app.id])
}

resource "aws_lambda_permission" "get_drop_job_apps_lambda_permission_http_api" {
  function_name = aws_lambda_function.get_drop_job_apps_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_get_drop_job_apps" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.get_drop_job_apps_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_get_v1_orgs_orgid_var_jobs_jobid_var_apps_dropped" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "GET /v1/orgs/{orgId}/jobs/{jobId}/apps/dropped"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_get_drop_job_apps.id])
}

resource "aws_lambda_permission" "get_full_job_app_detail_lambda_permission_http_api" {
  function_name = aws_lambda_function.get_full_job_app_detail_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_get_full_job_app_detail" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.get_full_job_app_detail_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_get_v1_orgs_orgid_var_jobs_jobid_var_apps_appid_var" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "GET /v1/orgs/{orgId}/jobs/{jobId}/apps/{appId}"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_get_full_job_app_detail.id])
}

resource "aws_lambda_permission" "undrop_job_app_lambda_permission_http_api" {
  function_name = aws_lambda_function.undrop_job_app_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_undrop_job_app" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.undrop_job_app_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_post_v1_orgs_orgid_var_jobs_jobid_var_apps_appid_var_undrop" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "POST /v1/orgs/{orgId}/jobs/{jobId}/apps/{appId}/undrop"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_undrop_job_app.id])
}

resource "aws_lambda_permission" "emulate_job_apply_lambda_permission_http_api" {
  function_name = aws_lambda_function.emulate_job_apply_lambda_function.arn
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = join("", ["arn:", data.aws_partition.current.partition, ":execute-api:", data.aws_region.current.name, ":", data.aws_caller_identity.current.account_id, ":", aws_apigatewayv2_api.http_api.id, "/*"])
}

resource "aws_apigatewayv2_integration" "http_api_integration_emulate_job_apply" {
  api_id = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.emulate_job_apply_lambda_function.arn
  payload_format_version = "2.0"
  // CF Property(TimeoutInMillis) = 30000
}

resource "aws_apigatewayv2_route" "http_api_route_post_v1_orgs_orgid_var_jobs_jobid_var_emulateapply" {
  api_id = aws_apigatewayv2_api.http_api.id
  route_key = "POST /v1/orgs/{orgId}/jobs/{jobId}/emulateApply"
  target = join("/", ["integrations", aws_apigatewayv2_integration.http_api_integration_emulate_job_apply.id])
}