resource "aws_lb_target_group" "verify_email_log_group" {
  name = "/aws/lambda/backend-dev-verifyEmail"
}

resource "aws_lb_target_group" "validate_reset_password_log_group" {
  name = "/aws/lambda/backend-dev-validateResetPassword"
}

resource "aws_lb_target_group" "reset_password_log_group" {
  name = "/aws/lambda/backend-dev-resetPassword"
}

resource "aws_lb_target_group" "update_email_log_group" {
  name = "/aws/lambda/backend-dev-updateEmail"
}

resource "aws_lb_target_group" "sign_up_log_group" {
  name = "/aws/lambda/backend-dev-signUp"
}

resource "aws_lb_target_group" "resend_email_log_group" {
  name = "/aws/lambda/backend-dev-resendEmail"
}

resource "aws_lb_target_group" "sign_in_log_group" {
  name = "/aws/lambda/backend-dev-signIn"
}

resource "aws_lb_target_group" "login_with_mera_id_log_group" {
  name = "/aws/lambda/backend-dev-loginWithMeraId"
}

resource "aws_lb_target_group" "collect_mera_id_status_log_group" {
  name = "/aws/lambda/backend-dev-collectMeraIdStatus"
}

resource "aws_lb_target_group" "request_password_reset_log_group" {
  name = "/aws/lambda/backend-dev-requestPasswordReset"
}

resource "aws_lb_target_group" "get_user_log_group" {
  name = "/aws/lambda/backend-dev-getUser"
}

resource "aws_lb_target_group" "document_upload_log_group" {
  name = "/aws/lambda/backend-dev-documentUpload"
}

resource "aws_lb_target_group" "resume_personal_info_log_group" {
  name = "/aws/lambda/backend-dev-resumePersonalInfo"
}

resource "aws_lb_target_group" "resume_continuation_log_group" {
  name = "/aws/lambda/backend-dev-resumeContinuation"
}

resource "aws_lb_target_group" "job_details_log_group" {
  name = "/aws/lambda/backend-dev-jobDetails"
}

resource "aws_lb_target_group" "apply_for_job_log_group" {
  name = "/aws/lambda/backend-dev-applyForJob"
}

resource "aws_lb_target_group" "apply_via_mera_id_log_group" {
  name = "/aws/lambda/backend-dev-applyViaMeraID"
}

resource "aws_lb_target_group" "apply_via_mera_id_status_log_group" {
  name = "/aws/lambda/backend-dev-applyViaMeraIDStatus"
}

resource "aws_lb_target_group" "get_resume_log_group" {
  name = "/aws/lambda/backend-dev-getResume"
}

resource "aws_lb_target_group" "get_job_app_hist_log_group" {
  name = "/aws/lambda/backend-dev-getJobAppHist"
}

resource "aws_lb_target_group" "get_job_app_detail_log_group" {
  name = "/aws/lambda/backend-dev-getJobAppDetail"
}

resource "aws_lb_target_group" "withdraw_job_app_log_group" {
  name = "/aws/lambda/backend-dev-withdrawJobApp"
}

resource "aws_lb_target_group" "get_jobs_log_group" {
  name = "/aws/lambda/backend-dev-getJobs"
}

resource "aws_lb_target_group" "get_job_applications_log_group" {
  name = "/aws/lambda/backend-dev-getJobApplications"
}

resource "aws_lb_target_group" "ack_csv_upload_log_group" {
  name = "/aws/lambda/backend-dev-ackCsvUpload"
}

resource "aws_lb_target_group" "get_candidate_groups_log_group" {
  name = "/aws/lambda/backend-dev-getCandidateGroups"
}

resource "aws_lb_target_group" "notify_job_candidates_log_group" {
  name = "/aws/lambda/backend-dev-notifyJobCandidates"
}

resource "aws_lb_target_group" "get_applicant_group_file_log_group" {
  name = "/aws/lambda/backend-dev-getApplicantGroupFile"
}

resource "aws_lb_target_group" "get_notifications_log_group" {
  name = "/aws/lambda/backend-dev-getNotifications"
}

resource "aws_lb_target_group" "delete_candidate_group_log_group" {
  name = "/aws/lambda/backend-dev-deleteCandidateGroup"
}

resource "aws_lb_target_group" "update_profile_log_group" {
  name = "/aws/lambda/backend-dev-updateProfile"
}

resource "aws_lb_target_group" "profile_log_group" {
  name = "/aws/lambda/backend-dev-profile"
}

resource "aws_lb_target_group" "create_job_log_group" {
  name = "/aws/lambda/backend-dev-createJob"
}

resource "aws_lb_target_group" "update_job_log_group" {
  name = "/aws/lambda/backend-dev-updateJob"
}

resource "aws_lb_target_group" "delete_job_log_group" {
  name = "/aws/lambda/backend-dev-deleteJob"
}

resource "aws_lb_target_group" "expire_job_log_group" {
  name = "/aws/lambda/backend-dev-expireJob"
}

resource "aws_lb_target_group" "create_org_log_group" {
  name = "/aws/lambda/backend-dev-createOrg"
}

resource "aws_lb_target_group" "update_org_log_group" {
  name = "/aws/lambda/backend-dev-updateOrg"
}

resource "aws_lb_target_group" "get_orgs_log_group" {
  name = "/aws/lambda/backend-dev-getOrgs"
}

resource "aws_lb_target_group" "delete_org_log_group" {
  name = "/aws/lambda/backend-dev-deleteOrg"
}

resource "aws_lb_target_group" "org_details_log_group" {
  name = "/aws/lambda/backend-dev-orgDetails"
}

resource "aws_lb_target_group" "create_org_role_log_group" {
  name = "/aws/lambda/backend-dev-createOrgRole"
}

resource "aws_lb_target_group" "update_org_role_log_group" {
  name = "/aws/lambda/backend-dev-updateOrgRole"
}

resource "aws_lb_target_group" "delete_org_role_log_group" {
  name = "/aws/lambda/backend-dev-deleteOrgRole"
}

resource "aws_lb_target_group" "get_org_roles_log_group" {
  name = "/aws/lambda/backend-dev-getOrgRoles"
}

resource "aws_lb_target_group" "get_org_members_log_group" {
  name = "/aws/lambda/backend-dev-getOrgMembers"
}

resource "aws_lb_target_group" "delete_org_member_log_group" {
  name = "/aws/lambda/backend-dev-deleteOrgMember"
}

resource "aws_lb_target_group" "create_org_member_log_group" {
  name = "/aws/lambda/backend-dev-createOrgMember"
}

resource "aws_lb_target_group" "update_org_member_log_group" {
  name = "/aws/lambda/backend-dev-updateOrgMember"
}

resource "aws_lb_target_group" "create_org_pipeline_log_group" {
  name = "/aws/lambda/backend-dev-createOrgPipeline"
}

resource "aws_lb_target_group" "get_org_pipeline_log_group" {
  name = "/aws/lambda/backend-dev-getOrgPipeline"
}

resource "aws_lb_target_group" "delete_org_pipeline_log_group" {
  name = "/aws/lambda/backend-dev-deleteOrgPipeline"
}

resource "aws_lb_target_group" "update_org_pipeline_log_group" {
  name = "/aws/lambda/backend-dev-updateOrgPipeline"
}

resource "aws_lb_target_group" "get_org_jobs_log_group" {
  name = "/aws/lambda/backend-dev-getOrgJobs"
}

resource "aws_lb_target_group" "delete_org_job_log_group" {
  name = "/aws/lambda/backend-dev-deleteOrgJob"
}

resource "aws_lb_target_group" "create_org_job_log_group" {
  name = "/aws/lambda/backend-dev-createOrgJob"
}

resource "aws_lb_target_group" "update_org_info_log_group" {
  name = "/aws/lambda/backend-dev-updateOrgInfo"
}

resource "aws_lb_target_group" "update_org_job_log_group" {
  name = "/aws/lambda/backend-dev-updateOrgJob"
}

resource "aws_lb_target_group" "get_job_info_log_group" {
  name = "/aws/lambda/backend-dev-getJobInfo"
}

resource "aws_lb_target_group" "get_job_apps_log_group" {
  name = "/aws/lambda/backend-dev-getJobApps"
}

resource "aws_lb_target_group" "forward_job_app_log_group" {
  name = "/aws/lambda/backend-dev-forwardJobApp"
}

resource "aws_lb_target_group" "post_job_app_score_log_group" {
  name = "/aws/lambda/backend-dev-postJobAppScore"
}

resource "aws_lb_target_group" "post_job_app_comment_log_group" {
  name = "/aws/lambda/backend-dev-postJobAppComment"
}

resource "aws_lb_target_group" "drop_job_app_log_group" {
  name = "/aws/lambda/backend-dev-dropJobApp"
}

resource "aws_lb_target_group" "get_drop_job_apps_log_group" {
  name = "/aws/lambda/backend-dev-getDropJobApps"
}

resource "aws_lb_target_group" "get_full_job_app_detail_log_group" {
  name = "/aws/lambda/backend-dev-getFullJobAppDetail"
}

resource "aws_lb_target_group" "undrop_job_app_log_group" {
  name = "/aws/lambda/backend-dev-undropJobApp"
}

resource "aws_lb_target_group" "emulate_job_apply_log_group" {
  name = "/aws/lambda/backend-dev-emulateJobApply"
}

resource "aws_lb_target_group" "http_api_log_group" {
  name = "/aws/http-api/job-app-backend-dev"
}