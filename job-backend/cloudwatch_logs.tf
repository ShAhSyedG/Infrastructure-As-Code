resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_verify_email_log_group_us_east1" {
  name = "sub-filter-verify-email"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.verify_email_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_validate_reset_password_log_group_us_east1" {
  name = "filter-validate-reset-password"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.validate_reset_password_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_reset_password_log_group_us_east1" {
  name = "reset-password"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.reset_password_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_update_email_log_group_us_east1" {
  name = "filter-update-email"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.update_email_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_sign_up_log_group_us_east1" {
  name = "filter-sign-up"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.sign_up_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_resend_email_log_group_us_east1" {
  name = "filter-resend-email"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.resend_email_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_sign_in_log_group_us_east1" {
  name = "filter-sign-in"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.sign_in_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_login_with_mera_id_log_group_us_east1" {
  name = "login-with-meraid"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.login_with_mera_id_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_collect_mera_id_status_log_group_us_east1" {
  name = "collect-meraid-status"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.collect_mera_id_status_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_request_password_reset_log_group_us_east1" {
  name = "request-password-reset"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.request_password_reset_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_get_user_log_group_us_east1" {
  name = "filter-get-user"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.get_user_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_document_upload_log_group_us_east1" {
  name = "document-upload-log"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.document_upload_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_resume_personal_info_log_group_us_east1" {
  name = "resume-personal-info"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.resume_personal_info_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_resume_continuation_log_group_us_east1" {
  name = "resume-continuation"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.resume_continuation_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_job_details_log_group_us_east1" {
  name = "job-details-logs"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.job_details_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_apply_for_job_log_group_us_east1" {
  name = "apply-for-job-log"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.apply_for_job_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_apply_via_mera_id_log_group_us_east1" {
  name = "apply-via-mera-id"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.apply_via_mera_id_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_apply_via_mera_id_status_log_group_us_east1" {
  name = "apply-mera-id-status"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.apply_via_mera_id_status_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_get_resume_log_group_us_east1" {
  name = "get-name-log"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.get_resume_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_get_job_app_hist_log_group_us_east1" {
  name = "get-job-hist"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.get_job_app_hist_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_get_job_app_detail_log_group_us_east1" {
  name = "get-job-detail"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.get_job_app_detail_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_withdraw_job_app_log_group_us_east1" {
  name = "withdraw-job-app"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.withdraw_job_app_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_get_jobs_log_group_us_east1" {
  name = "get-jobs-log"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.get_jobs_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_get_job_applications_log_group_us_east1" {
  name = "get-job-applications"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.get_job_applications_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_ack_csv_upload_log_group_us_east1" {
  name = "ack-csv-upload"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.ack_csv_upload_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_get_candidate_groups_log_group_us_east1" {
  name = "get-candidate-groups"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.get_candidate_groups_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_notify_job_candidates_log_group_us_east1" {
  name = "notify-job-candidates"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.notify_job_candidates_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_get_applicant_group_file_log_group_us_east1" {
  name = "get-applicant-group"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.get_applicant_group_file_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_get_notifications_log_group_us_east1" {
  name = "get-notifications-log"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.get_notifications_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_delete_candidate_group_log_group_us_east1" {
  name = "delete-candidate-group"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.delete_candidate_group_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_update_profile_log_group_us_east1" {
  name = "update-profile"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.update_profile_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_profile_log_group_us_east1" {
  name = "filter-profile-log"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.profile_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_create_job_log_group_us_east1" {
  name = "create-job"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.create_job_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_update_job_log_group_us_east1" {
  name = "update-job-log"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.update_job_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_delete_job_log_group_us_east1" {
  name = "delete-job-log"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.delete_job_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_expire_job_log_group_us_east1" {
  name = "expire-job-log"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.expire_job_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_create_org_log_group_us_east1" {
  name = "create-org-log"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.create_org_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_update_org_log_group_us_east1" {
  name = "filter-update-org"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.update_org_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_get_orgs_log_group_us_east1" {
  name = "get-orgs-log"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.get_orgs_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_delete_org_log_group_us_east1" {
  name = "delete-org-log"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.delete_org_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_org_details_log_group_us_east1" {
  name = "org-details-log"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.org_details_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_create_org_role_log_group_us_east1" {
  name  = "create-org-role"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.create_org_role_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_update_org_role_log_group_us_east1" {
  name = "update-org-role"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.update_org_role_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_delete_org_role_log_group_us_east1" {
  name = "delete-org-role"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.delete_org_role_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_get_org_roles_log_group_us_east1" {
  name = "get-org-roles"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.get_org_roles_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_get_org_members_log_group_us_east1" {
  name = "get-org-members"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.get_org_members_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_delete_org_member_log_group_us_east1" {
  name = "delete-org-member"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.delete_org_member_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_create_org_member_log_group_us_east1" {
  name = "create-org-member"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.create_org_member_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_update_org_member_log_group_us_east1" {
  name = "update-org-member"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.update_org_member_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_create_org_pipeline_log_group_us_east1" {
  name = "create-org-pipeline"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.create_org_pipeline_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_get_org_pipeline_log_group_us_east1" {
  name = "get-org-pipeline"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.get_org_pipeline_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_delete_org_pipeline_log_group_us_east1" {
  name = "delete-org-pipeline"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.delete_org_pipeline_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_update_org_pipeline_log_group_us_east1" {
  name = "update-org-pipeline"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.update_org_pipeline_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_get_org_jobs_log_group_us_east1" {
  name = "filter-get-org"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.get_org_jobs_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_delete_org_job_log_group_us_east1" {
  name = "delete-org-job"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.delete_org_job_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_create_org_job_log_group_us_east1" {
  name = "create-org-job"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.create_org_job_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_update_org_info_log_group_us_east1" {
  name = "update-org-info"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.update_org_info_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_update_org_job_log_group_us_east1" {
  name = "update-org-job"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.update_org_job_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_get_job_info_log_group_us_east1" {
  name = "get-job-info"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.get_job_info_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_get_job_apps_log_group_us_east1" {
  name = "get-job-apps"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.get_job_apps_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_forward_job_app_log_group_us_east1" {
  name = "forward-job-app"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.forward_job_app_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_post_job_app_score_log_group_us_east1" {
  name = "post-job-app-score"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.post_job_app_score_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_post_job_app_comment_log_group_us_east1" {
  name = "post-job-app-comment"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.post_job_app_comment_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_drop_job_app_log_group_us_east1" {
  name = "drop-job-app"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.drop_job_app_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_get_drop_job_apps_log_group_us_east1" {
  name = "get-drop-job-apps"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.get_drop_job_apps_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_get_full_job_app_detail_log_group_us_east1" {
  name = "get-full-job-app-details"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.get_full_job_app_detail_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_undrop_job_app_log_group_us_east1" {
  name = "undrop-job-app"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.undrop_job_app_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_emulate_job_apply_log_group_us_east1" {
  name = "emulate-job-apply"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "?\"REPORT RequestId: \" ?\"SERVERLESS_ENTERPRISE\""
  log_group_name = aws_lb_target_group.emulate_job_apply_log_group.arn_suffix
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_sub_filter_http_api_log_group_us_east1" {
  name = "http-api"
  destination_arn = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
  filter_pattern = "SLS_HTTP_API_LOG"
  log_group_name = aws_lb_target_group.http_api_log_group.arn_suffix
}