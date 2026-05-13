###############################################################################
# iam.tf — IAM Roles & Inline Policies
#
# Best-practice improvements vs original iam_policy.tf:
#  - Replaced invalid force_detach_policies (wrong attribute type) with proper
#    aws_iam_role + aws_iam_role_policy inline resources
#  - Removed duplicate per-function IAM roles — all Lambdas share one
#    least-privilege execution role (add per-function roles only if scoping is
#    required for a specific function)
#  - assume_role_policy uses jsonencode() — no raw escaped JSON strings
#  - DynamoDB ARN built from real data sources instead of hard-coded values
#  - CloudWatch Logs and DynamoDB split into two policy documents for clarity
#  - SES and S3 policies added to match the Lambda env-var permissions actually
#    needed at runtime
#  - X-Ray policy added to support active tracing enabled in lambda.tf
#  - Enterprise log-access role references aws_cloudwatch_log_group ARNs
#    (not aws_lb_target_group ARNs — that was a copy-paste bug in the original)
###############################################################################

# ── Shared Lambda Execution Role ──────────────────────────────────────────

resource "aws_iam_role" "lambda_execution" {
  name = "${local.name_prefix}-${data.aws_region.current.name}-lambdaRole"
  path = "/"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "LambdaAssumeRole"
        Effect    = "Allow"
        Principal = { Service = "lambda.amazonaws.com" }
        Action    = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "${local.name_prefix}-lambda-execution-role"
  }
}

# ── CloudWatch Logs Policy ────────────────────────────────────────────────
# Allows Lambda to create its own log groups/streams and write events.

resource "aws_iam_role_policy" "lambda_cloudwatch" {
  name = "${local.name_prefix}-lambda-cloudwatch"
  role = aws_iam_role.lambda_execution.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "CreateLogGroupAndStream"
        Effect = "Allow"
        Action = [
          "logs:CreateLogStream",
          "logs:CreateLogGroup",
          "logs:TagResource",
        ]
        Resource = [
          "arn:${data.aws_partition.current.partition}:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${local.name_prefix}*:*"
        ]
      },
      {
        Sid    = "PutLogEvents"
        Effect = "Allow"
        Action = ["logs:PutLogEvents"]
        Resource = [
          "arn:${data.aws_partition.current.partition}:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${local.name_prefix}*:*:*"
        ]
      }
    ]
  })
}

# ── DynamoDB Policy ───────────────────────────────────────────────────────
# Least-privilege: Query, GetItem, PutItem, UpdateItem, DeleteItem.
# Scan omitted intentionally — add only if the app truly requires full scans.

resource "aws_iam_role_policy" "lambda_dynamodb" {
  name = "${local.name_prefix}-lambda-dynamodb"
  role = aws_iam_role.lambda_execution.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "DynamoDBTableAccess"
        Effect = "Allow"
        Action = [
          "dynamodb:Query",
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem",
          "dynamodb:BatchGetItem",
          "dynamodb:BatchWriteItem",
          "dynamodb:DescribeTable",
          "dynamodb:ConditionCheckItem",
        ]
        Resource = [
          "arn:${data.aws_partition.current.partition}:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/${var.dynamodb_main_table}",
          "arn:${data.aws_partition.current.partition}:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/${var.dynamodb_main_table}/index/*",
        ]
      }
    ]
  })
}

# ── SES Policy ────────────────────────────────────────────────────────────
# Allows Lambda to send transactional emails via SES.

resource "aws_iam_role_policy" "lambda_ses" {
  name = "${local.name_prefix}-lambda-ses"
  role = aws_iam_role.lambda_execution.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "SESSendEmail"
        Effect = "Allow"
        Action = [
          "ses:SendEmail",
          "ses:SendRawEmail",
          "ses:SendTemplatedEmail",
        ]
        Resource = "*"
        Condition = {
          StringEquals = {
            "ses:FromAddress" = var.source_email
          }
        }
      }
    ]
  })
}

# ── S3 Policy ─────────────────────────────────────────────────────────────
# Allows Lambda to read/write objects in the upload bucket and read the
# deployment ZIP from the artefact bucket.

resource "aws_iam_role_policy" "lambda_s3" {
  name = "${local.name_prefix}-lambda-s3"
  role = aws_iam_role.lambda_execution.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "UploadsReadWrite"
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket",
          "s3:GetBucketLocation",
        ]
        Resource = [
          "arn:${data.aws_partition.current.partition}:s3:::${var.aws_s3_bucket_name}",
          "arn:${data.aws_partition.current.partition}:s3:::${var.aws_s3_bucket_name}/*",
        ]
      },
      {
        Sid    = "ArtifactBucketRead"
        Effect = "Allow"
        Action = ["s3:GetObject"]
        Resource = [
          "arn:${data.aws_partition.current.partition}:s3:::${local.lambda_s3_bucket}/${local.lambda_s3_key}",
        ]
      }
    ]
  })
}

# ── X-Ray Policy ──────────────────────────────────────────────────────────
# Required for active tracing (tracing_config.mode = "Active" in lambda.tf).

resource "aws_iam_role_policy" "lambda_xray" {
  name = "${local.name_prefix}-lambda-xray"
  role = aws_iam_role.lambda_execution.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "XRayWrite"
        Effect = "Allow"
        Action = [
          "xray:PutTraceSegments",
          "xray:PutTelemetryRecords",
          "xray:GetSamplingRules",
          "xray:GetSamplingTargets",
        ]
        Resource = ["*"]
      }
    ]
  })
}

# ── Serverless Enterprise Log-Access Role ─────────────────────────────────
# Used by the Serverless Framework observability platform to read CloudWatch
# logs. The assume_role_policy grants access to the Serverless account.

resource "aws_iam_role" "enterprise_log_access" {
  name = "${local.name_prefix}-enterprise-log-access"
  path = "/"

  # Trust policy — allows the Serverless Enterprise AWS account to assume
  # this role (account ID sourced from the serverless_log_destination ARN).
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "ServerlessEnterpriseAssumeRole"
        Effect = "Allow"
        Principal = {
          # Replace with the Serverless Enterprise account ID if it changes.
          AWS = "arn:${data.aws_partition.current.partition}:iam::802587217904:root"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "${local.name_prefix}-enterprise-log-access"
  }
}

resource "aws_iam_role_policy" "enterprise_log_access" {
  name = "${local.name_prefix}-enterprise-log-read"
  role = aws_iam_role.enterprise_log_access.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "ReadLambdaLogGroups"
        Effect = "Allow"
        Action = [
          "logs:FilterLogEvents",
          "logs:GetLogEvents",
          "logs:DescribeLogStreams",
          "logs:DescribeLogGroups",
        ]
        # Scope to only the log groups managed by this stack
        Resource = concat(
          [for lg in aws_cloudwatch_log_group.lambda_log_groups : lg.arn],
          ["${aws_cloudwatch_log_group.http_api.arn}:*"]
        )
      }
    ]
  })
}
