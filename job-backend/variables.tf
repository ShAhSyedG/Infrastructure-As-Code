###############################################################################
# variables.tf — Input Variable Declarations
#
# Best-practice improvements vs original variable.tf:
#  - File renamed variable.tf → variables.tf (Terraform convention)
#  - All var.some_value placeholders replaced with real, documented variables
#  - Only truly-secret values marked sensitive = true
#  - Type constraints and validation blocks added throughout
#  - Non-secret variables have sensible defaults so tfvars stay minimal
###############################################################################

# ── Core / Deployment ──────────────────────────────────────────────────────

variable "aws_region" {
  description = "AWS region where all resources are deployed."
  type        = string
  default     = "us-east-1"
}

variable "stage" {
  description = "Deployment stage / environment name."
  type        = string

  validation {
    condition     = contains(["dev", "staging", "prod"], var.stage)
    error_message = "stage must be one of: dev, staging, prod."
  }
}

variable "lambda_zip_version" {
  description = "Timestamp-based version folder for the Lambda deployment ZIP in S3 (e.g. 1677757776022-2023-03-02T11:49:36.022Z)."
  type        = string
}

variable "lambda_runtime" {
  description = "Lambda runtime identifier. nodejs14.x is EOL — use nodejs20.x or later."
  type        = string
  default     = "nodejs20.x"

  validation {
    condition     = can(regex("^nodejs(18|20|22)\\.x$", var.lambda_runtime))
    error_message = "lambda_runtime must be nodejs18.x, nodejs20.x, or nodejs22.x."
  }
}

variable "lambda_memory_size" {
  description = "Memory allocated to each Lambda function in MB (128–10240)."
  type        = number
  default     = 1024

  validation {
    condition     = var.lambda_memory_size >= 128 && var.lambda_memory_size <= 10240
    error_message = "lambda_memory_size must be between 128 and 10240 MB."
  }
}

variable "lambda_timeout" {
  description = "Lambda function timeout in seconds (1–900)."
  type        = number
  default     = 6

  validation {
    condition     = var.lambda_timeout >= 1 && var.lambda_timeout <= 900
    error_message = "lambda_timeout must be between 1 and 900 seconds."
  }
}

variable "log_retention_days" {
  description = "CloudWatch log group retention period in days."
  type        = number
  default     = 30

  validation {
    condition = contains(
      [1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1096, 1827, 2192, 2557, 2922, 3288, 3653],
      var.log_retention_days
    )
    error_message = "log_retention_days must be an AWS-accepted value (e.g. 7, 14, 30, 90, 365)."
  }
}

# ── Application ────────────────────────────────────────────────────────────

variable "is_offline" {
  description = "Whether the app runs in offline/local mode ('true'/'false' string for serverless-offline)."
  type        = string
  default     = "false"

  validation {
    condition     = contains(["true", "false"], var.is_offline)
    error_message = "is_offline must be 'true' or 'false'."
  }
}

variable "protocol" {
  description = "API Gateway protocol type."
  type        = string
  default     = "HTTP"

  validation {
    condition     = contains(["HTTP", "WEBSOCKET"], var.protocol)
    error_message = "protocol must be HTTP or WEBSOCKET."
  }
}

variable "dynamodb_main_table" {
  description = "Name of the primary DynamoDB table used by the application."
  type        = string
}

variable "backend_api_url" {
  description = "Public URL of the backend API (e.g. https://api.dev.jobapp.pk)."
  type        = string
}

variable "frontend_app_url" {
  description = "Public URL of the frontend application (e.g. https://dev.jobapp.pk)."
  type        = string
}

variable "project_name" {
  description = "Human-readable project name used in tags and environment variables."
  type        = string
  default     = "JobApp"
}

variable "source_email" {
  description = "SES sender address for outbound emails."
  type        = string
}

variable "reply_to_address" {
  description = "Reply-To address for outbound emails."
  type        = string
}

# ── S3 / File Uploads ──────────────────────────────────────────────────────

variable "aws_s3_bucket_name" {
  description = "S3 bucket used for document / resume uploads."
  type        = string
}

variable "basefolder_path" {
  description = "Root prefix inside the uploads bucket (e.g. 'uploads')."
  type        = string
  default     = "uploads"
}

variable "max_size_length" {
  description = "Maximum allowed upload size in bytes (string, passed as env var)."
  type        = string
  default     = "10485760" # 10 MiB
}

variable "pre_sign_expiry_time" {
  description = "Seconds until an S3 pre-signed URL expires."
  type        = string
  default     = "3600"
}

# ── Notifications / Export ─────────────────────────────────────────────────

variable "apps_export_name" {
  description = "CloudFormation / SSM export name for cross-stack references."
  type        = string
}

variable "notifications_limit" {
  description = "Maximum number of notifications returned per request (string env var)."
  type        = string
  default     = "20"
}

# ── Expiry / Token Settings ────────────────────────────────────────────────

variable "email_expiry" {
  description = "Email verification token TTL in seconds."
  type        = string
  default     = "86400"
}

variable "reset_password_expiry" {
  description = "Password-reset token TTL in seconds."
  type        = string
  default     = "3600"
}

variable "email_change_expiry" {
  description = "Email-change verification token TTL in seconds."
  type        = string
  default     = "3600"
}

variable "reject_pass_after_mera_id" {
  description = "Block password login once a user links MeraID ('true'/'false' string)."
  type        = string
  default     = "false"
}

variable "reject_pass_after_meraid" {
  description = "Alias of reject_pass_after_mera_id kept for backwards compatibility."
  type        = string
  default     = "false"
}

# ── MeraID Integration ─────────────────────────────────────────────────────

variable "meraid_base_url" {
  description = "Base URL for the MeraID API."
  type        = string
}

variable "meraid_auth_endpoint" {
  description = "MeraID auth endpoint path."
  type        = string
  default     = "/auth"
}

variable "meraid_collect_endpoint" {
  description = "MeraID collect endpoint path."
  type        = string
  default     = "/collect"
}

variable "meraid_sign_endpoint" {
  description = "MeraID sign endpoint path."
  type        = string
  default     = "/sign"
}

variable "meraid_app_id" {
  description = "Application ID registered with MeraID."
  type        = string
}

variable "meraid_reg_id" {
  description = "Registration ID registered with MeraID."
  type        = string
}

# ── Secrets (sensitive = true) ─────────────────────────────────────────────

variable "jwt_secret" {
  description = "Secret key used to sign and verify JWT tokens. Pass via TF_VAR_jwt_secret — never commit."
  type        = string
  sensitive   = true
}

variable "meraid_private_key" {
  description = "PEM private key for MeraID request signing. Pass via TF_VAR_meraid_private_key — never commit."
  type        = string
  sensitive   = true
}

# ── Serverless Enterprise Observability ────────────────────────────────────

variable "serverless_log_destination" {
  description = "CloudWatch Logs destination ARN for Serverless Enterprise log forwarding. Leave empty to disable."
  type        = string
  default     = ""
}
