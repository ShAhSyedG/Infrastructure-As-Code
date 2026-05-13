###############################################################################
# cloudwatch.tf — CloudWatch Log Groups & Subscription Filters
#
# Best-practice improvements vs original cloudwatch_logs.tf / loadbalancer.tf:
#  - All log groups are now aws_cloudwatch_log_group (not aws_lb_target_group!)
#    The original mistakenly used aws_lb_target_group as a log destination —
#    LB target groups are not CloudWatch log groups.
#  - for_each over a local set eliminates ~65 copy-pasted resource blocks
#  - retention_in_days applied uniformly via var.log_retention_days
#  - kms_key_id hook left as a commented best-practice reminder for prod
#  - Log subscription filters collapsed into for_each (only created when
#    var.serverless_log_destination is non-empty)
###############################################################################

locals {
  # Canonical set of all Lambda function short-names.
  # Keep this in sync with local.lambda_functions in lambda.tf.
  # To add a function: add one entry here AND one in lambda.tf.
  lambda_names = toset([
    "verifyEmail",
    "validateResetPassword",
    "resetPassword",
    "updateEmail",
    "signUp",
    "resendEmail",
    "signIn",
    "loginWithMeraId",
    "collectMeraIdStatus",
    "requestPasswordReset",
    "getUser",
    "documentUpload",
    "resumePersonalInfo",
    "resumeContinuation",
    "jobDetails",
    "applyForJob",
    "applyViaMeraID",
    "applyViaMeraIDStatus",
    "getResume",
    "getJobAppHist",
    "getJobAppDetail",
    "withdrawJobApp",
    "getJobs",
    "getJobApplications",
    "ackCsvUpload",
    "getCandidateGroups",
    "notifyJobCandidates",
    "getApplicantGroupFile",
    "getNotifications",
    "deleteCandidateGroup",
    "updateProfile",
    "profile",
    "createJob",
    "updateJob",
    "deleteJob",
    "expireJob",
    "createOrg",
    "updateOrg",
    "getOrgs",
    "deleteOrg",
    "orgDetails",
    "createOrgRole",
    "updateOrgRole",
    "deleteOrgRole",
    "getOrgRoles",
    "getOrgMembers",
    "deleteOrgMember",
    "createOrgMember",
    "updateOrgMember",
    "createOrgPipeline",
    "getOrgPipeline",
    "deleteOrgPipeline",
    "updateOrgPipeline",
    "getOrgJobs",
    "deleteOrgJob",
    "createOrgJob",
    "updateOrgInfo",
    "updateOrgJob",
    "getJobInfo",
    "getJobApps",
    "forwardJobApp",
    "postJobAppScore",
    "postJobAppComment",
    "dropJobApp",
    "getDropJobApps",
    "getFullJobAppDetail",
    "undropJobApp",
    "emulateJobApply",
  ])
}

# ── Per-Lambda Log Groups ─────────────────────────────────────────────────

resource "aws_cloudwatch_log_group" "lambda_log_groups" {
  for_each = local.lambda_names

  name              = "/aws/lambda/${local.name_prefix}-${each.key}"
  retention_in_days = var.log_retention_days

  # Encrypt logs with a customer-managed KMS key (recommended for prod):
  # kms_key_id = aws_kms_key.logs.arn

  tags = {
    Function = each.key
  }
}

# ── HTTP API Gateway Log Group ────────────────────────────────────────────

resource "aws_cloudwatch_log_group" "http_api" {
  name              = "/aws/apigateway/${local.name_prefix}"
  retention_in_days = var.log_retention_days

  # kms_key_id = aws_kms_key.logs.arn

  tags = {
    Name = "${local.name_prefix}-apigw-logs"
  }
}

# ── Serverless Enterprise Subscription Filters ────────────────────────────
# Only created when var.serverless_log_destination is a non-empty string.
# This forwards logs to the Serverless Framework observability platform.

resource "aws_cloudwatch_log_subscription_filter" "enterprise" {
  for_each = var.serverless_log_destination != "" ? local.lambda_names : toset([])

  name            = "${local.name_prefix}-${each.key}-enterprise"
  log_group_name  = aws_cloudwatch_log_group.lambda_log_groups[each.key].name
  filter_pattern  = ""
  destination_arn = var.serverless_log_destination

  depends_on = [aws_cloudwatch_log_group.lambda_log_groups]
}
