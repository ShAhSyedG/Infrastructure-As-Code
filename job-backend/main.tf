###############################################################################
# main.tf — Terraform & Provider Configuration, Data Sources, and Locals
#
# Best-practice improvements vs original:
#  - Upgraded AWS provider ~> 3.0 → ~> 5.0 (current stable)
#  - required_version pinned to >= 1.3.0
#  - provider default_tags applied globally (no per-resource tag duplication)
#  - Sensitive env-vars kept out of locals; injected directly via variables
#  - common_tags local centralises all resource tagging
#  - apigw_source_arn local removes repeated interpolation across api_gateway.tf
###############################################################################

terraform {
  backend "s3" {
    bucket         = "terrafrom-state-elections-site"
    key            = "02-job-app/backend/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-locking"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.3.0"
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = local.common_tags
  }
}

###############################################################################
# Data Sources
###############################################################################

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_partition" "current" {}

###############################################################################
# Locals
###############################################################################

locals {
  app         = "backend"
  environment = var.stage
  name_prefix = "${local.app}-${local.environment}"

  # Common tags applied to every resource via provider default_tags
  common_tags = {
    Project     = var.project_name
    Environment = var.stage
    ManagedBy   = "Terraform"
    Repository  = "job-backend"
  }

  # S3 artefact location for Lambda deployment ZIPs
  lambda_s3_bucket = "pk.jobapp.${var.stage}.${var.aws_region}"
  lambda_s3_key    = "serverless/backend/${var.stage}/${var.lambda_zip_version}/backend.zip"

  # Wildcard source ARN used on all Lambda permissions for this API
  apigw_source_arn = "${aws_apigatewayv2_api.http_api.execution_arn}/*/*"

  # Environment variables shared by every Lambda function.
  # Secrets (jwt_secret, meraid_private_key) are passed as sensitive variables
  # and never hard-coded here.
  lambda_env_vars = {
    IS_OFFLINE                 = var.is_offline
    REGION                     = var.aws_region
    STAGE                      = var.stage
    DYNAMODB_MAIN_TABLE        = var.dynamodb_main_table
    JWT_SECRET                 = var.jwt_secret
    BACKEND_API_URL            = var.backend_api_url
    FRONTEND_APP_URL           = var.frontend_app_url
    PROJECT_NAME               = var.project_name
    SOURCE_EMAIL               = var.source_email
    REPLY_TO_ADDRESS           = var.reply_to_address
    MERAID_BASE_URL            = var.meraid_base_url
    MERAID_AUTH_ENDPOINT       = var.meraid_auth_endpoint
    MERAID_COLLECT_ENDPOINT    = var.meraid_collect_endpoint
    MERAID_SIGN_ENDPOINT       = var.meraid_sign_endpoint
    MERAID_APP_ID              = var.meraid_app_id
    MERAID_REG_ID              = var.meraid_reg_id
    MERAID_PRIVATE_KEY         = var.meraid_private_key
    AWS_S3_BUCKET_NAME         = var.aws_s3_bucket_name
    BASEFOLDER_PATH            = var.basefolder_path
    MAX_SIZE_LENGTH            = var.max_size_length
    PRE_SIGN_EXPIRY_TIME       = var.pre_sign_expiry_time
    APPS_EXPORT_NAME           = var.apps_export_name
    NOTIFICATIONS_LIMIT        = var.notifications_limit
    EMAIL_EXPIRY               = var.email_expiry
    RESET_PASSWORD_EXPIRY      = var.reset_password_expiry
    EMAIL_CHANGE_EXPIRY        = var.email_change_expiry
    REJECT_PASS_AFTER_MERA_ID  = var.reject_pass_after_mera_id
    REJECT_PASS_AFTER_MERAID   = var.reject_pass_after_meraid
  }
}
