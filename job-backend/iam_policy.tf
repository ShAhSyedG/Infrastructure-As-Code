resource "aws_iam_role" "iam_role_lambda_execution" {
  assume_role_policy = {
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = [
            "lambda.amazonaws.com"
          ]
        }
        Action = [
          "sts:AssumeRole"
        ]
      }
    ]
  }
  force_detach_policies = [
    {
      PolicyName = join("-", ["backend", "dev", "lambda"])
      PolicyDocument = {
        Version = "2012-10-17"
        Statement = [
          {
            Effect = "Allow"
            Action = [
              "logs:CreateLogStream",
              "logs:CreateLogGroup",
              "logs:TagResource"
            ]
            Resource = [
              "arn:${data.aws_partition.current.partition}:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/backend-dev*:*"
            ]
          },
          {
            Effect = "Allow"
            Action = [
              "logs:PutLogEvents"
            ]
            Resource = [
              "arn:${data.aws_partition.current.partition}:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/backend-dev*:*:*"
            ]
          },
          {
            Effect = "Allow"
            Action = [
              "dynamodb:DescribeTable",
              "dynamodb:Query",
              "dynamodb:GetItem",
              "dynamodb:PutItem",
              "dynamodb:UpdateItem"
            ]
            Resource = [
              "arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/job-app-backend-dev",
              "arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/job-app-backend-dev/index/GSI1"
            ]
          }
        ]
      }
    }
  ]
  path = "/"
  name = join("-", ["backend", "dev", data.aws_region.current.name, "lambdaRole"])
}

resource "aws_iam_role" "enterprise_log_access_iam_role" {
  assume_role_policy = {
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::802587217904:root"
        }
        Action = "sts:AssumeRole"
        Condition = {
          StringEquals = {
            "sts:ExternalId" = "ServerlessEnterprise-100d0245-7bf0-4f2a-a8e9-6742f1d5bf72"
          }
        }
      }
    ]
  }
  force_detach_policies = [
    {
      PolicyName = "LogFilterAccess"
      PolicyDocument = {
        Version = "2012-10-17"
        Statement = [
          {
            Effect = "Allow"
            Action = [
              "logs:FilterLogEvents"
            ]
            Resource = [
              aws_lb_target_group.verify_email_log_group.arn,
              aws_lb_target_group.validate_reset_password_log_group.arn,
              aws_lb_target_group.reset_password_log_group.arn,
              aws_lb_target_group.update_email_log_group.arn,
              aws_lb_target_group.sign_up_log_group.arn,
              aws_lb_target_group.resend_email_log_group.arn,
              aws_lb_target_group.sign_in_log_group.arn,
              aws_lb_target_group.login_with_mera_id_log_group.arn,
              aws_lb_target_group.collect_mera_id_status_log_group.arn,
              aws_lb_target_group.request_password_reset_log_group.arn,
              aws_lb_target_group.get_user_log_group.arn,
              aws_lb_target_group.document_upload_log_group.arn,
              aws_lb_target_group.resume_personal_info_log_group.arn,
              aws_lb_target_group.resume_continuation_log_group.arn,
              aws_lb_target_group.job_details_log_group.arn,
              aws_lb_target_group.apply_for_job_log_group.arn,
              aws_lb_target_group.apply_via_mera_id_log_group.arn,
              aws_lb_target_group.apply_via_mera_id_status_log_group.arn,
              aws_lb_target_group.get_resume_log_group.arn,
              aws_lb_target_group.get_job_app_hist_log_group.arn,
              aws_lb_target_group.get_job_app_detail_log_group.arn,
              aws_lb_target_group.withdraw_job_app_log_group.arn,
              aws_lb_target_group.get_jobs_log_group.arn,
              aws_lb_target_group.get_job_applications_log_group.arn,
              aws_lb_target_group.ack_csv_upload_log_group.arn,
              aws_lb_target_group.get_candidate_groups_log_group.arn,
              aws_lb_target_group.notify_job_candidates_log_group.arn,
              aws_lb_target_group.get_applicant_group_file_log_group.arn,
              aws_lb_target_group.get_notifications_log_group.arn,
              aws_lb_target_group.delete_candidate_group_log_group.arn,
              aws_lb_target_group.update_profile_log_group.arn,
              aws_lb_target_group.profile_log_group.arn,
              aws_lb_target_group.create_job_log_group.arn,
              aws_lb_target_group.update_job_log_group.arn,
              aws_lb_target_group.delete_job_log_group.arn,
              aws_lb_target_group.expire_job_log_group.arn,
              aws_lb_target_group.create_org_log_group.arn,
              aws_lb_target_group.update_org_log_group.arn,
              aws_lb_target_group.get_orgs_log_group.arn,
              aws_lb_target_group.delete_org_log_group.arn,
              aws_lb_target_group.org_details_log_group.arn,
              aws_lb_target_group.create_org_role_log_group.arn,
              aws_lb_target_group.update_org_role_log_group.arn,
              aws_lb_target_group.delete_org_role_log_group.arn,
              aws_lb_target_group.get_org_roles_log_group.arn,
              aws_lb_target_group.get_org_members_log_group.arn,
              aws_lb_target_group.delete_org_member_log_group.arn,
              aws_lb_target_group.create_org_member_log_group.arn,
              aws_lb_target_group.update_org_member_log_group.arn,
              aws_lb_target_group.create_org_pipeline_log_group.arn,
              aws_lb_target_group.get_org_pipeline_log_group.arn,
              aws_lb_target_group.delete_org_pipeline_log_group.arn,
              aws_lb_target_group.update_org_pipeline_log_group.arn,
              aws_lb_target_group.get_org_jobs_log_group.arn,
              aws_lb_target_group.delete_org_job_log_group.arn,
              aws_lb_target_group.create_org_job_log_group.arn,
              aws_lb_target_group.update_org_info_log_group.arn,
              aws_lb_target_group.update_org_job_log_group.arn,
              aws_lb_target_group.get_job_info_log_group.arn,
              aws_lb_target_group.get_job_apps_log_group.arn,
              aws_lb_target_group.forward_job_app_log_group.arn,
              aws_lb_target_group.post_job_app_score_log_group.arn,
              aws_lb_target_group.post_job_app_comment_log_group.arn,
              aws_lb_target_group.drop_job_app_log_group.arn,
              aws_lb_target_group.get_drop_job_apps_log_group.arn,
              aws_lb_target_group.get_full_job_app_detail_log_group.arn,
              aws_lb_target_group.undrop_job_app_log_group.arn,
              aws_lb_target_group.emulate_job_apply_log_group.arn
            ]
          }
        ]
      }
    }
  ]
}

resource "aws_iam_role" "sign_up_iam_role_lambda_execution" {
  assume_role_policy = {
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = [
            "lambda.amazonaws.com"
          ]
        }
        Action = [
          "sts:AssumeRole"
        ]
      }
    ]
  }
  force_detach_policies = [
    {
      PolicyName = join("-", ["backend", "dev", "lambda"])
      PolicyDocument = {
        Version = "2012-10-17"
        Statement = [
          {
            Effect = "Allow"
            Action = [
              "logs:CreateLogStream",
              "logs:CreateLogGroup",
              "logs:PutLogEvents"
            ]
            Resource = [
              "arn:${data.aws_partition.current.partition}:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/backend-dev-signUp:*:*"
            ]
          },
          {
            Effect = "Allow"
            Action = [
              "dynamodb:DescribeTable",
              "dynamodb:Query",
              "dynamodb:GetItem",
              "dynamodb:PutItem",
              "dynamodb:UpdateItem"
            ]
            Resource = [
              "arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/job-app-backend-dev",
              "arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/job-app-backend-dev/index/GSI1"
            ]
          },
          {
            Effect = "Allow"
            Action = [
              "ses:SendEmail",
              "ses:SendRawEmail"
            ]
            Resource = "*"
          }
        ]
      }
    }
  ]
  path = "/"
  name = join("-", ["backend", "dev", "signUp", data.aws_region.current.name, "lambdaRole"])
  managed_policy_arns = [
  ]
}

resource "aws_iam_role" "resend_email_iam_role_lambda_execution" {
  assume_role_policy = {
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = [
            "lambda.amazonaws.com"
          ]
        }
        Action = [
          "sts:AssumeRole"
        ]
      }
    ]
  }
  force_detach_policies = [
    {
      PolicyName = join("-", ["backend", "dev", "lambda"])
      PolicyDocument = {
        Version = "2012-10-17"
        Statement = [
          {
            Effect = "Allow"
            Action = [
              "logs:CreateLogStream",
              "logs:CreateLogGroup",
              "logs:PutLogEvents"
            ]
            Resource = [
              "arn:${data.aws_partition.current.partition}:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/backend-dev-resendEmail:*:*"
            ]
          },
          {
            Effect = "Allow"
            Action = [
              "dynamodb:DescribeTable",
              "dynamodb:Query",
              "dynamodb:GetItem",
              "dynamodb:PutItem",
              "dynamodb:UpdateItem"
            ]
            Resource = [
              "arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/job-app-backend-dev",
              "arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/job-app-backend-dev/index/GSI1"
            ]
          },
          {
            Effect = "Allow"
            Action = [
              "ses:SendEmail",
              "ses:SendRawEmail"
            ]
            Resource = "*"
          }
        ]
      }
    }
  ]
  path = "/"
  name = join("-", ["backend", "dev", "resendEmail", data.aws_region.current.name, "lambdaRole"])
  managed_policy_arns = [
  ]
}

resource "aws_iam_role" "request_password_reset_iam_role_lambda_execution" {
  assume_role_policy = {
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = [
            "lambda.amazonaws.com"
          ]
        }
        Action = [
          "sts:AssumeRole"
        ]
      }
    ]
  }
  force_detach_policies = [
    {
      PolicyName = join("-", ["backend", "dev", "lambda"])
      PolicyDocument = {
        Version = "2012-10-17"
        Statement = [
          {
            Effect = "Allow"
            Action = [
              "logs:CreateLogStream",
              "logs:CreateLogGroup",
              "logs:PutLogEvents"
            ]
            Resource = [
              "arn:${data.aws_partition.current.partition}:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/backend-dev-requestPasswordReset:*:*"
            ]
          },
          {
            Effect = "Allow"
            Action = [
              "dynamodb:DescribeTable",
              "dynamodb:Query",
              "dynamodb:GetItem",
              "dynamodb:PutItem",
              "dynamodb:UpdateItem"
            ]
            Resource = [
              "arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/job-app-backend-dev",
              "arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/job-app-backend-dev/index/GSI1"
            ]
          },
          {
            Effect = "Allow"
            Action = [
              "ses:SendEmail",
              "ses:SendRawEmail"
            ]
            Resource = "*"
          }
        ]
      }
    }
  ]
  path = "/"
  name = join("-", ["backend", "dev", "requestPasswordReset", data.aws_region.current.name, "lambdaRole"])
  managed_policy_arns = [
  ]
}

resource "aws_iam_role" "document_upload_iam_role_lambda_execution" {
  assume_role_policy = {
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = [
            "lambda.amazonaws.com"
          ]
        }
        Action = [
          "sts:AssumeRole"
        ]
      }
    ]
  }
  force_detach_policies = [
    {
      PolicyName = join("-", ["backend", "dev", "lambda"])
      PolicyDocument = {
        Version = "2012-10-17"
        Statement = [
          {
            Effect = "Allow"
            Action = [
              "logs:CreateLogStream",
              "logs:CreateLogGroup",
              "logs:PutLogEvents"
            ]
            Resource = [
              "arn:${data.aws_partition.current.partition}:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/backend-dev-documentUpload:*:*"
            ]
          },
          {
            Effect = "Allow"
            Action = [
              "dynamodb:DescribeTable",
              "dynamodb:Query",
              "dynamodb:GetItem",
              "dynamodb:PutItem",
              "dynamodb:UpdateItem"
            ]
            Resource = [
              "arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/job-app-backend-dev",
              "arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/job-app-backend-dev/index/GSI1"
            ]
          },
          {
            Effect = "Allow"
            Action = [
              "s3:*"
            ]
            Resource = "arn:aws:s3:::jobapp.pk-dev-us-east-1-media/*"
          }
        ]
      }
    }
  ]
  path = "/"
  name = join("-", ["backend", "dev", "documentUpload", data.aws_region.current.name, "lambdaRole"])
  managed_policy_arns = [
  ]
}

resource "aws_iam_role" "get_resume_iam_role_lambda_execution" {
  assume_role_policy = {
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = [
            "lambda.amazonaws.com"
          ]
        }
        Action = [
          "sts:AssumeRole"
        ]
      }
    ]
  }
  force_detach_policies = [
    {
      PolicyName = join("-", ["backend", "dev", "lambda"])
      PolicyDocument = {
        Version = "2012-10-17"
        Statement = [
          {
            Effect = "Allow"
            Action = [
              "logs:CreateLogStream",
              "logs:CreateLogGroup",
              "logs:PutLogEvents"
            ]
            Resource = [
              "arn:${data.aws_partition.current.partition}:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/backend-dev-getResume:*:*"
            ]
          },
          {
            Effect = "Allow"
            Action = [
              "dynamodb:DescribeTable",
              "dynamodb:Query",
              "dynamodb:GetItem",
              "dynamodb:PutItem",
              "dynamodb:UpdateItem"
            ]
            Resource = [
              "arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/job-app-backend-dev",
              "arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/job-app-backend-dev/index/GSI1"
            ]
          },
          {
            Effect = "Allow"
            Action = [
              "s3:GetObject"
            ]
            Resource = "arn:aws:s3:::jobapp.pk-dev-us-east-1-media/*"
          }
        ]
      }
    }
  ]
  path = "/"
  name = join("-", ["backend", "dev", "getResume", data.aws_region.current.name, "lambdaRole"])
  managed_policy_arns = [
  ]
}

resource "aws_iam_role" "get_job_applications_iam_role_lambda_execution" {
  assume_role_policy = {
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = [
            "lambda.amazonaws.com"
          ]
        }
        Action = [
          "sts:AssumeRole"
        ]
      }
    ]
  }
  force_detach_policies = [
    {
      PolicyName = join("-", ["backend", "dev", "lambda"])
      PolicyDocument = {
        Version = "2012-10-17"
        Statement = [
          {
            Effect = "Allow"
            Action = [
              "logs:CreateLogStream",
              "logs:CreateLogGroup",
              "logs:PutLogEvents"
            ]
            Resource = [
              "arn:${data.aws_partition.current.partition}:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/backend-dev-getJobApplications:*:*"
            ]
          },
          {
            Effect = "Allow"
            Action = [
              "dynamodb:DescribeTable",
              "dynamodb:Query",
              "dynamodb:GetItem",
              "dynamodb:PutItem",
              "dynamodb:UpdateItem"
            ]
            Resource = [
              "arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/job-app-backend-dev",
              "arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/job-app-backend-dev/index/GSI1"
            ]
          },
          {
            Effect = "Allow"
            Action = [
              "s3:*"
            ]
            Resource = "arn:aws:s3:::jobapp.pk-dev-us-east-1-media/*"
          }
        ]
      }
    }
  ]
  path = "/"
  name = join("-", ["backend", "dev", "getJobApplications", data.aws_region.current.name, "lambdaRole"])
  managed_policy_arns = [
  ]
}

resource "aws_iam_role" "notify_job_candidates_iam_role_lambda_execution" {
  assume_role_policy = {
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = [
            "lambda.amazonaws.com"
          ]
        }
        Action = [
          "sts:AssumeRole"
        ]
      }
    ]
  }
  force_detach_policies = [
    {
      PolicyName = join("-", ["backend", "dev", "lambda"])
      PolicyDocument = {
        Version = "2012-10-17"
        Statement = [
          {
            Effect = "Allow"
            Action = [
              "logs:CreateLogStream",
              "logs:CreateLogGroup",
              "logs:PutLogEvents"
            ]
            Resource = [
              "arn:${data.aws_partition.current.partition}:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/backend-dev-notifyJobCandidates:*:*"
            ]
          },
          {
            Effect = "Allow"
            Action = [
              "dynamodb:DescribeTable",
              "dynamodb:Query",
              "dynamodb:GetItem",
              "dynamodb:PutItem",
              "dynamodb:UpdateItem"
            ]
            Resource = [
              "arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/job-app-backend-dev",
              "arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/job-app-backend-dev/index/GSI1"
            ]
          },
          {
            Effect = "Allow"
            Action = [
              "s3:*"
            ]
            Resource = "arn:aws:s3:::jobapp.pk-dev-us-east-1-media/*"
          },
          {
            Effect = "Allow"
            Action = [
              "ses:SendEmail",
              "ses:SendRawEmail"
            ]
            Resource = "*"
          }
        ]
      }
    }
  ]
  path = "/"
  name = join("-", ["backend", "dev", "notifyJobCandidates", data.aws_region.current.name, "lambdaRole"])
  managed_policy_arns = [
  ]
}

resource "aws_iam_role" "get_applicant_group_file_iam_role_lambda_execution" {
  assume_role_policy = {
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = [
            "lambda.amazonaws.com"
          ]
        }
        Action = [
          "sts:AssumeRole"
        ]
      }
    ]
  }
  force_detach_policies = [
    {
      PolicyName = join("-", ["backend", "dev", "lambda"])
      PolicyDocument = {
        Version = "2012-10-17"
        Statement = [
          {
            Effect = "Allow"
            Action = [
              "logs:CreateLogStream",
              "logs:CreateLogGroup",
              "logs:PutLogEvents"
            ]
            Resource = [
              "arn:${data.aws_partition.current.partition}:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/backend-dev-getApplicantGroupFile:*:*"
            ]
          },
          {
            Effect = "Allow"
            Action = [
              "dynamodb:DescribeTable",
              "dynamodb:Query",
              "dynamodb:GetItem",
              "dynamodb:PutItem",
              "dynamodb:UpdateItem"
            ]
            Resource = [
              "arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/job-app-backend-dev",
              "arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/job-app-backend-dev/index/GSI1"
            ]
          },
          {
            Effect = "Allow"
            Action = [
              "s3:GetObject"
            ]
            Resource = "arn:aws:s3:::jobapp.pk-dev-us-east-1-media/*"
          }
        ]
      }
    }
  ]
  path = "/"
  name = join("-", ["backend", "dev", "getApplicantGroupFile", data.aws_region.current.name, "lambdaRole"])
  managed_policy_arns = [
  ]
}

resource "aws_iam_role" "update_profile_iam_role_lambda_execution" {
  assume_role_policy = {
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = [
            "lambda.amazonaws.com"
          ]
        }
        Action = [
          "sts:AssumeRole"
        ]
      }
    ]
  }
  force_detach_policies = [
    {
      PolicyName = join("-", ["backend", "dev", "lambda"])
      PolicyDocument = {
        Version = "2012-10-17"
        Statement = [
          {
            Effect = "Allow"
            Action = [
              "logs:CreateLogStream",
              "logs:CreateLogGroup",
              "logs:PutLogEvents"
            ]
            Resource = [
              "arn:${data.aws_partition.current.partition}:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/backend-dev-updateProfile:*:*"
            ]
          },
          {
            Effect = "Allow"
            Action = [
              "dynamodb:DescribeTable",
              "dynamodb:Query",
              "dynamodb:GetItem",
              "dynamodb:PutItem",
              "dynamodb:UpdateItem"
            ]
            Resource = [
              "arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/job-app-backend-dev",
              "arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/job-app-backend-dev/index/GSI1"
            ]
          },
          {
            Effect = "Allow"
            Action = [
              "ses:SendEmail",
              "ses:SendRawEmail"
            ]
            Resource = "*"
          }
        ]
      }
    }
  ]
  path = "/"
  name = join("-", ["backend", "dev", "updateProfile", data.aws_region.current.name, "lambdaRole"])
  managed_policy_arns = [
  ]
}

resource "aws_iam_role" "profile_iam_role_lambda_execution" {
  assume_role_policy = {
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = [
            "lambda.amazonaws.com"
          ]
        }
        Action = [
          "sts:AssumeRole"
        ]
      }
    ]
  }
  force_detach_policies = [
    {
      PolicyName = join("-", ["backend", "dev", "lambda"])
      PolicyDocument = {
        Version = "2012-10-17"
        Statement = [
          {
            Effect = "Allow"
            Action = [
              "logs:CreateLogStream",
              "logs:CreateLogGroup",
              "logs:PutLogEvents"
            ]
            Resource = [
              "arn:${data.aws_partition.current.partition}:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/backend-dev-profile:*:*"
            ]
          },
          {
            Effect = "Allow"
            Action = [
              "dynamodb:DescribeTable",
              "dynamodb:Query",
              "dynamodb:GetItem",
              "dynamodb:PutItem",
              "dynamodb:UpdateItem"
            ]
            Resource = [
              "arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/job-app-backend-dev",
              "arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/job-app-backend-dev/index/GSI1"
            ]
          },
          {
            Effect = "Allow"
            Action = [
              "s3:GetObject"
            ]
            Resource = "arn:aws:s3:::jobapp.pk-dev-us-east-1-media/*"
          }
        ]
      }
    }
  ]
  path = "/"
  name = join("-", ["backend", "dev", "profile", data.aws_region.current.name, "lambdaRole"])
  managed_policy_arns = [
  ]
}

resource "aws_iam_role" "get_orgs_iam_role_lambda_execution" {
  assume_role_policy = {
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = [
            "lambda.amazonaws.com"
          ]
        }
        Action = [
          "sts:AssumeRole"
        ]
      }
    ]
  }
  force_detach_policies = [
    {
      PolicyName = join("-", ["backend", "dev", "lambda"])
      PolicyDocument = {
        Version = "2012-10-17"
        Statement = [
          {
            Effect = "Allow"
            Action = [
              "logs:CreateLogStream",
              "logs:CreateLogGroup",
              "logs:PutLogEvents"
            ]
            Resource = [
              "arn:${data.aws_partition.current.partition}:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/backend-dev-getOrgs:*:*"
            ]
          },
          {
            Effect = "Allow"
            Action = [
              "dynamodb:DescribeTable",
              "dynamodb:Query",
              "dynamodb:GetItem",
              "dynamodb:PutItem",
              "dynamodb:UpdateItem"
            ]
            Resource = [
              "arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/job-app-backend-dev",
              "arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/job-app-backend-dev/index/GSI1"
            ]
          },
          {
            Effect = "Allow"
            Action = [
              "s3:GetObject"
            ]
            Resource = "arn:aws:s3:::jobapp.pk-dev-us-east-1-media/*"
          }
        ]
      }
    }
  ]
  path = "/"
  name = join("-", ["backend", "dev", "getOrgs", data.aws_region.current.name, "lambdaRole"])
  managed_policy_arns = [
  ]
}

resource "aws_iam_role" "org_details_iam_role_lambda_execution" {
  assume_role_policy = {
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = [
            "lambda.amazonaws.com"
          ]
        }
        Action = [
          "sts:AssumeRole"
        ]
      }
    ]
  }
  force_detach_policies = [
    {
      PolicyName = join("-", ["backend", "dev", "lambda"])
      PolicyDocument = {
        Version = "2012-10-17"
        Statement = [
          {
            Effect = "Allow"
            Action = [
              "logs:CreateLogStream",
              "logs:CreateLogGroup",
              "logs:PutLogEvents"
            ]
            Resource = [
              "arn:${data.aws_partition.current.partition}:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/backend-dev-orgDetails:*:*"
            ]
          },
          {
            Effect = "Allow"
            Action = [
              "dynamodb:DescribeTable",
              "dynamodb:Query",
              "dynamodb:GetItem",
              "dynamodb:PutItem",
              "dynamodb:UpdateItem"
            ]
            Resource = [
              "arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/job-app-backend-dev",
              "arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/job-app-backend-dev/index/GSI1"
            ]
          },
          {
            Effect = "Allow"
            Action = [
              "s3:GetObject"
            ]
            Resource = "arn:aws:s3:::jobapp.pk-dev-us-east-1-media/*"
          }
        ]
      }
    }
  ]
  path = "/"
  name = join("-", ["backend", "dev", "orgDetails", data.aws_region.current.name, "lambdaRole"])
  managed_policy_arns = [
  ]
}

resource "aws_iam_role" "get_job_apps_iam_role_lambda_execution" {
  assume_role_policy = {
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = [
            "lambda.amazonaws.com"
          ]
        }
        Action = [
          "sts:AssumeRole"
        ]
      }
    ]
  }
  force_detach_policies = [
    {
      PolicyName = join("-", ["backend", "dev", "lambda"])
      PolicyDocument = {
        Version = "2012-10-17"
        Statement = [
          {
            Effect = "Allow"
            Action = [
              "logs:CreateLogStream",
              "logs:CreateLogGroup",
              "logs:PutLogEvents"
            ]
            Resource = [
              "arn:${data.aws_partition.current.partition}:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/backend-dev-getJobApps:*:*"
            ]
          },
          {
            Effect = "Allow"
            Action = [
              "dynamodb:DescribeTable",
              "dynamodb:Query",
              "dynamodb:GetItem",
              "dynamodb:PutItem",
              "dynamodb:UpdateItem"
            ]
            Resource = [
              "arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/job-app-backend-dev",
              "arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/job-app-backend-dev/index/GSI1"
            ]
          },
          {
            Effect = "Allow"
            Action = [
              "s3:GetObject"
            ]
            Resource = "arn:aws:s3:::jobapp.pk-dev-us-east-1-media/*"
          }
        ]
      }
    }
  ]
  path = "/"
  name = join("-", ["backend", "dev", "getJobApps", data.aws_region.current.name, "lambdaRole"])
  managed_policy_arns = [
  ]
}

resource "aws_iam_role" "get_full_job_app_detail_iam_role_lambda_execution" {
  assume_role_policy = {
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = [
            "lambda.amazonaws.com"
          ]
        }
        Action = [
          "sts:AssumeRole"
        ]
      }
    ]
  }
  force_detach_policies = [
    {
      PolicyName = join("-", ["backend", "dev", "lambda"])
      PolicyDocument = {
        Version = "2012-10-17"
        Statement = [
          {
            Effect = "Allow"
            Action = [
              "logs:CreateLogStream",
              "logs:CreateLogGroup",
              "logs:PutLogEvents"
            ]
            Resource = [
              "arn:${data.aws_partition.current.partition}:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/backend-dev-getFullJobAppDetail:*:*"
            ]
          },
          {
            Effect = "Allow"
            Action = [
              "dynamodb:DescribeTable",
              "dynamodb:Query",
              "dynamodb:GetItem",
              "dynamodb:PutItem",
              "dynamodb:UpdateItem"
            ]
            Resource = [
              "arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/job-app-backend-dev",
              "arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/job-app-backend-dev/index/GSI1"
            ]
          },
          {
            Effect = "Allow"
            Action = [
              "s3:GetObject"
            ]
            Resource = "arn:aws:s3:::jobapp.pk-dev-us-east-1-media/*"
          }
        ]
      }
    }
  ]
  path = "/"
  name = join("-", ["backend", "dev", "getFullJobAppDetail", data.aws_region.current.name, "lambdaRole"])
  managed_policy_arns = [
  ]
}

resource "aws_dynamodb_table" "main_table" {
  name = "job-app-backend-dev"
  attribute {
      name = "PK"
      type = "S"
    }
  attribute {
      name = "SK"
      type = "S"
    }
  attribute {
      name = "PK1"
      type = "S"
    }
    attribute {
      name = "SK1"
      type = "S"
    }
  // CF Property(KeySchema) = [
  //   {
  //     AttributeName = "PK"
  //     KeyType = "HASH"
  //   },
  //   {
  //     AttributeName = "SK"
  //     KeyType = "RANGE"
  //   }
  // ]
  billing_mode = "PAY_PER_REQUEST"
  global_secondary_index {
    name               = "GSI1"
    hash_key           = "PK1"
    range_key          = "SK1"
    write_capacity     = 5
    read_capacity      = 5

    projection_type    = "ALL"
  }
}

//resource "aws_s3_bucket" "s3_bucket" {
  //bucket = "jobapp.pk-dev-us-east-1-media"
  //cors_rule {
    // CF Property(CorsRules) = [
    //   {
    //     AllowedMethods = [
    //       "GET",
    //       "HEAD"
    //     ]
    //     AllowedOrigins = [
    //       "*"
    //     ]
    //     AllowedHeaders = [
    //       "*"
    //     ]
    //   }
    // ]
  //}
//}