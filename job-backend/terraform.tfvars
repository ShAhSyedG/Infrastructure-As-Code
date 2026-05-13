###############################################################################
# terraform.tfvars — Non-secret, environment-specific values (dev)
#
# IMPORTANT: Do NOT commit sensitive values (jwt_secret, meraid_private_key)
# to this file. Pass them via environment variables before running Terraform:
#
#   export TF_VAR_jwt_secret="<your-secret>"
#   export TF_VAR_meraid_private_key="<your-pem-key>"
#
# Or retrieve them from AWS SSM Parameter Store / Secrets Manager in CI/CD.
###############################################################################

# ── Core / Deployment ──────────────────────────────────────────────────────
aws_region         = "us-east-1"
stage              = "dev"
lambda_zip_version = "1677757776022-2023-03-02T11:49:36.022Z"
lambda_runtime     = "nodejs20.x"
lambda_memory_size = 1024
lambda_timeout     = 6
log_retention_days = 30

# ── Application ────────────────────────────────────────────────────────────
is_offline          = "false"
protocol            = "HTTP"
dynamodb_main_table = "job-app-backend-dev"
backend_api_url     = "https://api.dev.jobapp.pk"
frontend_app_url    = "https://dev.jobapp.pk"
project_name        = "JobApp"
source_email        = "noreply@dev.jobapp.pk"
reply_to_address    = "support@jobapp.pk"
aws_s3_bucket_name  = "pk.jobapp.dev.us-east-1"
basefolder_path     = "uploads"
max_size_length     = "10485760"
pre_sign_expiry_time = "3600"
apps_export_name    = "job-app-backend-dev"
notifications_limit = "20"

# ── Expiry / Token Settings ────────────────────────────────────────────────
email_expiry              = "86400"
reset_password_expiry     = "3600"
email_change_expiry       = "3600"
reject_pass_after_mera_id = "false"
reject_pass_after_meraid  = "false"

# ── MeraID (non-secret parts) ─────────────────────────────────────────────
meraid_base_url         = "https://api.meraid.pk"
meraid_auth_endpoint    = "/auth"
meraid_collect_endpoint = "/collect"
meraid_sign_endpoint    = "/sign"
meraid_app_id           = "jobapp-dev"
meraid_reg_id           = "jobapp-reg-dev"

# ── Serverless Enterprise ─────────────────────────────────────────────────
serverless_log_destination = "arn:aws:logs:us-east-1:802587217904:destination:100d0245-7bf0-4f2a-a8e9-6742f1d5bf72#800K8ZfywvZJw89lrK#backend#dev"
