###############################################################################
# lambda.tf — Lambda Functions
#
# Best-practice improvements vs original lambda.tf:
#  - Replaced invalid code_signing_config_arn map syntax with correct
#    s3_bucket + s3_key arguments (code_signing_config_arn is a string ARN,
#    not a map — it was entirely unused in the original)
#  - Eliminated ~65 copy-pasted resource blocks using for_each over a local map
#    that defines only the per-function handler name; all other attributes are
#    shared and DRY
#  - Runtime upgraded from EOL nodejs14.x → nodejs20.x (controlled via variable)
#  - var.some_value placeholders replaced with real, documented variables
#  - reserved_concurrent_executions = -1 (unlimited by default; set per-function
#    in the map below if throttling is required)
#  - X-Ray active tracing enabled for end-to-end observability
#  - Log groups pre-created in cloudwatch.tf; depends_on ensures correct ordering
#  - Function name pattern: <name_prefix>-<short_name> matches log group names
###############################################################################

locals {
  # Map of function short-name → handler.
  # Only the handler differs per function — everything else is shared.
  # To add a new function: add one entry here AND one matching entry in
  # cloudwatch.tf local.lambda_names.
  lambda_functions = {
    verifyEmail              = "s_verifyEmail.handler"
    validateResetPassword    = "s_validateResetPassword.handler"
    resetPassword            = "s_resetPassword.handler"
    updateEmail              = "s_updateEmail.handler"
    signUp                   = "s_signUp.handler"
    resendEmail              = "s_resendEmail.handler"
    signIn                   = "s_signIn.handler"
    loginWithMeraId          = "s_loginWithMeraId.handler"
    collectMeraIdStatus      = "s_collectMeraIdStatus.handler"
    requestPasswordReset     = "s_requestPasswordReset.handler"
    getUser                  = "s_getUser.handler"
    documentUpload           = "s_documentUpload.handler"
    resumePersonalInfo       = "s_resumePersonalInfo.handler"
    resumeContinuation       = "s_resumeContinuation.handler"
    jobDetails               = "s_jobDetails.handler"
    applyForJob              = "s_applyForJob.handler"
    applyViaMeraID           = "s_applyViaMeraID.handler"
    applyViaMeraIDStatus     = "s_applyViaMeraIDStatus.handler"
    getResume                = "s_getResume.handler"
    getJobAppHist            = "s_getJobAppHist.handler"
    getJobAppDetail          = "s_getJobAppDetail.handler"
    withdrawJobApp           = "s_withdrawJobApp.handler"
    getJobs                  = "s_getJobs.handler"
    getJobApplications       = "s_getJobApplications.handler"
    ackCsvUpload             = "s_ackCsvUpload.handler"
    getCandidateGroups       = "s_getCandidateGroups.handler"
    notifyJobCandidates      = "s_notifyJobCandidates.handler"
    getApplicantGroupFile    = "s_getApplicantGroupFile.handler"
    getNotifications         = "s_getNotifications.handler"
    deleteCandidateGroup     = "s_deleteCandidateGroup.handler"
    updateProfile            = "s_updateProfile.handler"
    profile                  = "s_profile.handler"
    createJob                = "s_createJob.handler"
    updateJob                = "s_updateJob.handler"
    deleteJob                = "s_deleteJob.handler"
    expireJob                = "s_expireJob.handler"
    createOrg                = "s_createOrg.handler"
    updateOrg                = "s_updateOrg.handler"
    getOrgs                  = "s_getOrgs.handler"
    deleteOrg                = "s_deleteOrg.handler"
    orgDetails               = "s_orgDetails.handler"
    createOrgRole            = "s_createOrgRole.handler"
    updateOrgRole            = "s_updateOrgRole.handler"
    deleteOrgRole            = "s_deleteOrgRole.handler"
    getOrgRoles              = "s_getOrgRoles.handler"
    getOrgMembers            = "s_getOrgMembers.handler"
    deleteOrgMember          = "s_deleteOrgMember.handler"
    createOrgMember          = "s_createOrgMember.handler"
    updateOrgMember          = "s_updateOrgMember.handler"
    createOrgPipeline        = "s_createOrgPipeline.handler"
    getOrgPipeline           = "s_getOrgPipeline.handler"
    deleteOrgPipeline        = "s_deleteOrgPipeline.handler"
    updateOrgPipeline        = "s_updateOrgPipeline.handler"
    getOrgJobs               = "s_getOrgJobs.handler"
    deleteOrgJob             = "s_deleteOrgJob.handler"
    createOrgJob             = "s_createOrgJob.handler"
    updateOrgInfo            = "s_updateOrgInfo.handler"
    updateOrgJob             = "s_updateOrgJob.handler"
    getJobInfo               = "s_getJobInfo.handler"
    getJobApps               = "s_getJobApps.handler"
    forwardJobApp            = "s_forwardJobApp.handler"
    postJobAppScore          = "s_postJobAppScore.handler"
    postJobAppComment        = "s_postJobAppComment.handler"
    dropJobApp               = "s_dropJobApp.handler"
    getDropJobApps           = "s_getDropJobApps.handler"
    getFullJobAppDetail      = "s_getFullJobAppDetail.handler"
    undropJobApp             = "s_undropJobApp.handler"
    emulateJobApply          = "s_emulateJobApply.handler"
  }
}

resource "aws_lambda_function" "functions" {
  for_each = local.lambda_functions

  function_name = "${local.name_prefix}-${each.key}"
  description   = "Job App Backend — ${each.key} (${var.stage})"

  # Deployment package — fetched from S3 at apply time
  s3_bucket = local.lambda_s3_bucket
  s3_key    = local.lambda_s3_key

  handler     = each.value
  runtime     = var.lambda_runtime
  memory_size = var.lambda_memory_size
  timeout     = var.lambda_timeout

  role = aws_iam_role.lambda_execution.arn

  # -1 = unlimited concurrent executions (default).
  # Override per-function in the map above if fine-grained throttling is needed.
  reserved_concurrent_executions = -1

  # X-Ray active tracing for end-to-end observability
  tracing_config {
    mode = "Active"
  }

  environment {
    variables = local.lambda_env_vars
  }

  # Ensure the log group exists before Lambda tries to write to it
  depends_on = [aws_cloudwatch_log_group.lambda_log_groups]

  tags = {
    Name = "${local.name_prefix}-${each.key}"
  }

  lifecycle {
    # Allow CI/CD pipelines to update the S3 key without Terraform interference
    ignore_changes = [s3_key]
  }
}
