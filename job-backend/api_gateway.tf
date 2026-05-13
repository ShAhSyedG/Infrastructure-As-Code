###############################################################################
# api_gateway.tf — API Gateway v2 (HTTP API)
#
# Best-practice improvements vs original api_gateway.tf:
#  - CORS configured on the API resource (not via invalid
#    aws_apigatewayv2_route_settings.cors_configuration — that sub-block does
#    not exist on that resource type)
#  - detailed_metrics_enabled = true on the stage for production-readiness
#  - access_log_settings uses the correct aws_cloudwatch_log_group ARN
#    (not an aws_lb_target_group ARN — that was a copy-paste bug)
#  - access_log format uses jsonencode() — no raw escaped strings
#  - Lambda permissions, integrations, and routes all collapsed into for_each
#    maps — eliminates ~200 copy-pasted resource blocks from the original
#  - source_arn on Lambda permissions uses local.apigw_source_arn (defined in
#    main.tf) instead of repeated interpolation
#  - Removed invalid CloudFormation // CF Property() comments
###############################################################################

# ── HTTP API ──────────────────────────────────────────────────────────────

resource "aws_apigatewayv2_api" "http_api" {
  name          = local.name_prefix
  protocol_type = var.protocol
  description   = "Job App Backend HTTP API (${var.stage})"

  cors_configuration {
    allow_headers = [
      "Content-Type",
      "X-Amz-Date",
      "Authorization",
      "X-Api-Key",
      "X-Amz-Security-Token",
      "X-Amz-User-Agent",
      "X-Amzn-Trace-Id",
    ]
    allow_methods = ["OPTIONS", "GET", "POST", "DELETE", "PUT", "PATCH"]
    # Restrict to known domain(s) in production instead of wildcard "*"
    allow_origins = ["*"]
    max_age       = 300
  }

  tags = {
    Name = "${local.name_prefix}-http-api"
  }
}

# ── Default Stage ─────────────────────────────────────────────────────────

resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.http_api.id
  name        = "$default"
  auto_deploy = true

  default_route_settings {
    detailed_metrics_enabled = true
    throttling_burst_limit   = 500
    throttling_rate_limit    = 1000
  }

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.http_api.arn
    format = jsonencode({
      requestTime        = "$context.requestTime"
      requestId          = "$context.requestId"
      apiId              = "$context.apiId"
      routeKey           = "$context.routeKey"
      path               = "$context.path"
      httpMethod         = "$context.httpMethod"
      stage              = "$context.stage"
      status             = "$context.status"
      integrationStatus  = "$context.integrationStatus"
      integrationLatency = "$context.integrationLatency"
      responseLatency    = "$context.responseLatency"
      responseLength     = "$context.responseLength"
      errorMessage       = "$context.error.message"
      sourceIp           = "$context.identity.sourceIp"
      userAgent          = "$context.identity.userAgent"
    })
  }

  tags = {
    Name = "${local.name_prefix}-default-stage"
  }
}

###############################################################################
# Lambda Permissions, Integrations, and Routes
#
# The route table below collapses ~200 copy-pasted resource blocks from the
# original into three for_each loops.
#
# Schema per entry:
#   "<short_name>" = { method = "METHOD", path = "/v1/path" }
#
# Adding a route: append one line here — no other file changes needed
# (assuming the Lambda function already exists in local.lambda_functions).
###############################################################################

locals {
  api_routes = {
    # ── Auth ───────────────────────────────────────────────────────────────
    verifyEmail           = { method = "GET",   path = "/v1/verify-email" }
    validateResetPassword = { method = "GET",   path = "/v1/validate-reset-password" }
    resetPassword         = { method = "POST",  path = "/v1/reset-password" }
    updateEmail           = { method = "POST",  path = "/v1/update-email" }
    signUp                = { method = "POST",  path = "/v1/sign-up" }
    resendEmail           = { method = "POST",  path = "/v1/resend-email" }
    signIn                = { method = "POST",  path = "/v1/sign-in" }
    loginWithMeraId       = { method = "POST",  path = "/v1/login-with-meraid" }
    collectMeraIdStatus   = { method = "POST",  path = "/v1/collect-meraid-status" }
    requestPasswordReset  = { method = "POST",  path = "/v1/request-password-reset" }

    # ── User / Profile ─────────────────────────────────────────────────────
    getUser               = { method = "GET",   path = "/v1/user" }
    updateProfile         = { method = "PUT",   path = "/v1/profile" }
    profile               = { method = "GET",   path = "/v1/profile" }

    # ── Documents & Resume ─────────────────────────────────────────────────
    documentUpload        = { method = "POST",  path = "/v1/document-upload" }
    resumePersonalInfo    = { method = "POST",  path = "/v1/resume/personal-info" }
    resumeContinuation    = { method = "POST",  path = "/v1/resume/continuation" }
    getResume             = { method = "GET",   path = "/v1/resume" }

    # ── Jobs (Candidate) ───────────────────────────────────────────────────
    getJobs               = { method = "GET",   path = "/v1/jobs" }
    jobDetails            = { method = "GET",   path = "/v1/jobs/{jobId}" }
    applyForJob           = { method = "POST",  path = "/v1/jobs/{jobId}/apply" }
    applyViaMeraID        = { method = "POST",  path = "/v1/jobs/{jobId}/apply-via-meraid" }
    applyViaMeraIDStatus  = { method = "POST",  path = "/v1/jobs/{jobId}/apply-via-meraid/status" }
    getJobAppHist         = { method = "GET",   path = "/v1/job-applications" }
    getJobAppDetail       = { method = "GET",   path = "/v1/job-applications/{applicationId}" }
    withdrawJobApp        = { method = "DELETE", path = "/v1/job-applications/{applicationId}" }
    getNotifications      = { method = "GET",   path = "/v1/notifications" }

    # ── CSV / Candidate Groups ─────────────────────────────────────────────
    ackCsvUpload          = { method = "POST",  path = "/v1/ack-csv-upload" }
    getCandidateGroups    = { method = "GET",   path = "/v1/candidate-groups" }
    notifyJobCandidates   = { method = "POST",  path = "/v1/notify-job-candidates" }
    getApplicantGroupFile = { method = "GET",   path = "/v1/applicant-group-file" }
    deleteCandidateGroup  = { method = "DELETE", path = "/v1/candidate-groups/{groupId}" }

    # ── Organisation Management ────────────────────────────────────────────
    createOrg             = { method = "POST",  path = "/v1/organisations" }
    updateOrg             = { method = "PUT",   path = "/v1/organisations/{orgId}" }
    getOrgs               = { method = "GET",   path = "/v1/organisations" }
    deleteOrg             = { method = "DELETE", path = "/v1/organisations/{orgId}" }
    orgDetails            = { method = "GET",   path = "/v1/organisations/{orgId}" }
    updateOrgInfo         = { method = "PATCH", path = "/v1/organisations/{orgId}/info" }

    # ── Organisation Roles ─────────────────────────────────────────────────
    createOrgRole         = { method = "POST",  path = "/v1/organisations/{orgId}/roles" }
    updateOrgRole         = { method = "PUT",   path = "/v1/organisations/{orgId}/roles/{roleId}" }
    deleteOrgRole         = { method = "DELETE", path = "/v1/organisations/{orgId}/roles/{roleId}" }
    getOrgRoles           = { method = "GET",   path = "/v1/organisations/{orgId}/roles" }

    # ── Organisation Members ───────────────────────────────────────────────
    getOrgMembers         = { method = "GET",   path = "/v1/organisations/{orgId}/members" }
    createOrgMember       = { method = "POST",  path = "/v1/organisations/{orgId}/members" }
    updateOrgMember       = { method = "PUT",   path = "/v1/organisations/{orgId}/members/{memberId}" }
    deleteOrgMember       = { method = "DELETE", path = "/v1/organisations/{orgId}/members/{memberId}" }

    # ── Organisation Pipelines ─────────────────────────────────────────────
    createOrgPipeline     = { method = "POST",  path = "/v1/organisations/{orgId}/pipelines" }
    getOrgPipeline        = { method = "GET",   path = "/v1/organisations/{orgId}/pipelines" }
    updateOrgPipeline     = { method = "PUT",   path = "/v1/organisations/{orgId}/pipelines/{pipelineId}" }
    deleteOrgPipeline     = { method = "DELETE", path = "/v1/organisations/{orgId}/pipelines/{pipelineId}" }

    # ── Organisation Jobs ──────────────────────────────────────────────────
    getOrgJobs            = { method = "GET",   path = "/v1/organisations/{orgId}/jobs" }
    createOrgJob          = { method = "POST",  path = "/v1/organisations/{orgId}/jobs" }
    updateOrgJob          = { method = "PUT",   path = "/v1/organisations/{orgId}/jobs/{jobId}" }
    deleteOrgJob          = { method = "DELETE", path = "/v1/organisations/{orgId}/jobs/{jobId}" }
    createJob             = { method = "POST",  path = "/v1/jobs" }
    updateJob             = { method = "PUT",   path = "/v1/jobs/{jobId}" }
    deleteJob             = { method = "DELETE", path = "/v1/jobs/{jobId}" }
    expireJob             = { method = "POST",  path = "/v1/jobs/{jobId}/expire" }

    # ── Recruiter / Job Applications ───────────────────────────────────────
    getJobInfo            = { method = "GET",   path = "/v1/recruiter/jobs/{jobId}" }
    getJobApps            = { method = "GET",   path = "/v1/recruiter/jobs/{jobId}/applications" }
    forwardJobApp         = { method = "POST",  path = "/v1/recruiter/applications/{applicationId}/forward" }
    postJobAppScore       = { method = "POST",  path = "/v1/recruiter/applications/{applicationId}/score" }
    postJobAppComment     = { method = "POST",  path = "/v1/recruiter/applications/{applicationId}/comment" }
    dropJobApp            = { method = "POST",  path = "/v1/recruiter/applications/{applicationId}/drop" }
    undropJobApp          = { method = "POST",  path = "/v1/recruiter/applications/{applicationId}/undrop" }
    getDropJobApps        = { method = "GET",   path = "/v1/recruiter/applications/dropped" }
    getFullJobAppDetail   = { method = "GET",   path = "/v1/recruiter/applications/{applicationId}" }
    getJobApplications    = { method = "GET",   path = "/v1/recruiter/applications" }
    emulateJobApply       = { method = "POST",  path = "/v1/recruiter/emulate-apply" }
  }
}

# ── Lambda Permissions ────────────────────────────────────────────────────
# Grants API Gateway permission to invoke each Lambda function.

resource "aws_lambda_permission" "api_gateway" {
  for_each = local.api_routes

  statement_id  = "AllowAPIGatewayInvoke-${each.key}"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.functions[each.key].function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = local.apigw_source_arn
}

# ── Lambda Integrations ───────────────────────────────────────────────────

resource "aws_apigatewayv2_integration" "lambda" {
  for_each = local.api_routes

  api_id                 = aws_apigatewayv2_api.http_api.id
  integration_type       = "AWS_PROXY"
  integration_uri        = aws_lambda_function.functions[each.key].invoke_arn
  payload_format_version = "2.0"
  timeout_milliseconds   = var.lambda_timeout * 1000
}

# ── Routes ────────────────────────────────────────────────────────────────

resource "aws_apigatewayv2_route" "lambda" {
  for_each = local.api_routes

  api_id    = aws_apigatewayv2_api.http_api.id
  route_key = "${each.value.method} ${each.value.path}"
  target    = "integrations/${aws_apigatewayv2_integration.lambda[each.key].id}"
}
