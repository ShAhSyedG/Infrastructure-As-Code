// Existing Terraform src code found at /var/folders/pn/jxjbyhm92pd1y25yg21ykpdw0000gn/T/terraform_src.

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_partition" "current" {}


resource "aws_lambda_function" "verify_email_lambda_function" {
  code_signing_config_arn = {
    S3Bucket = "pk.jobapp.dev.us-east-1"
    S3Key = "serverless/backend/dev/1677757776022-2023-03-02T11:49:36.022Z/backend.zip"
  }
  handler = "s_verifyEmail.handler"
  runtime = "nodejs14.x"
  function_name = "backend-dev-verifyEmail"
  memory_size = 1024
  timeout = 6
  architectures = [
    "arm64"
  ]
  environment {
    variables = {
      IS_OFFLINE = var.is_offline
      REGION = var.region
      STAGE = var.stage
      DYNAMODB_MAIN_TABLE = var.DYNAMODB_MAIN
      JWT_SECRET = var.jwt_secret
      BACKEND_API_URL = var.some_value 
      FRONTEND_APP_URL = var.some_value
      PROJECT_NAME = var.some_value
      SOURCE_EMAIL = var.some_value
      REPLY_TO_ADDRESS = var.some_value
      MERAID_PRIVATE_KEY = var.some_value
      MERAID_BASE_URL = var.some_value
      MERAID_AUTH_ENDPOINT = var.some_value
      MERAID_COLLECT_ENDPOINT = var.some_value
      BASEFOLDER_PATH = var.some_value
      MAX_SIZE_LENGTH = var.some_value
      AWS_S3_BUCKET_NAME = var.some_value
      PRE_SIGN_EXPIRY_TIME = var.some_value
      EMAIL_EXPIRY = var.some_value
      RESET_PASSWORD_EXPIRY = var.some_value
      REJECT_PASS_AFTER_MERA_ID = var.some_value
      MERAID_APP_ID = var.some_value
      MERAID_REG_ID = var.some_value
      REJECT_PASS_AFTER_MERAID = var.some_value
      EMAIL_CHANGE_EXPIRY = var.some_value
      MERAID_SIGN_ENDPOINT = var.some_value
      NOTIFICATIONS_LIMIT = var.some_value
      APPS_EXPORT_NAME = var.some_value
    }
  }
  role = aws_iam_role.iam_role_lambda_execution.arn
}

resource "aws_lambda_function" "validate_reset_password_lambda_function" {
  code_signing_config_arn = {
    S3Bucket = "pk.jobapp.dev.us-east-1"
    S3Key = "serverless/backend/dev/1677757776022-2023-03-02T11:49:36.022Z/backend.zip"
  }
  handler = "s_validateResetPassword.handler"
  runtime = "nodejs14.x"
  function_name = "backend-dev-validateResetPassword"
  memory_size = 1024
  timeout = 6
  architectures = [
    "arm64"
  ]
  environment {
    variables = {
      IS_OFFLINE = var.is_offline
      REGION = var.region
      STAGE = var.stage
      DYNAMODB_MAIN_TABLE = var.DYNAMODB_MAIN
      JWT_SECRET = var.jwt_secret
      BACKEND_API_URL = var.some_value 
      FRONTEND_APP_URL = var.some_value
      PROJECT_NAME = var.some_value
      SOURCE_EMAIL = var.some_value
      REPLY_TO_ADDRESS = var.some_value
      MERAID_PRIVATE_KEY = var.some_value
      MERAID_BASE_URL = var.some_value
      MERAID_AUTH_ENDPOINT = var.some_value
      MERAID_COLLECT_ENDPOINT = var.some_value
      BASEFOLDER_PATH = var.some_value
      MAX_SIZE_LENGTH = var.some_value
      AWS_S3_BUCKET_NAME = var.some_value
      PRE_SIGN_EXPIRY_TIME = var.some_value
      EMAIL_EXPIRY = var.some_value
      RESET_PASSWORD_EXPIRY = var.some_value
      REJECT_PASS_AFTER_MERA_ID = var.some_value
      MERAID_APP_ID = var.some_value
      MERAID_REG_ID = var.some_value
      REJECT_PASS_AFTER_MERAID = var.some_value
      EMAIL_CHANGE_EXPIRY = var.some_value
      MERAID_SIGN_ENDPOINT = var.some_value
      NOTIFICATIONS_LIMIT = var.some_value
      APPS_EXPORT_NAME = var.some_value
    }
  }
  role = aws_iam_role.iam_role_lambda_execution.arn
}

resource "aws_lambda_function" "reset_password_lambda_function" {
  code_signing_config_arn = {
    S3Bucket = "pk.jobapp.dev.us-east-1"
    S3Key = "serverless/backend/dev/1677757776022-2023-03-02T11:49:36.022Z/backend.zip"
  }
  handler = "s_resetPassword.handler"
  runtime = "nodejs14.x"
  function_name = "backend-dev-resetPassword"
  memory_size = 1024
  timeout = 6
  architectures = [
    "arm64"
  ]
  environment {
    variables = {
      IS_OFFLINE = var.is_offline
      REGION = var.region
      STAGE = var.stage
      DYNAMODB_MAIN_TABLE = var.DYNAMODB_MAIN
      JWT_SECRET = var.jwt_secret
      BACKEND_API_URL = var.some_value 
      FRONTEND_APP_URL = var.some_value
      PROJECT_NAME = var.some_value
      SOURCE_EMAIL = var.some_value
      REPLY_TO_ADDRESS = var.some_value
      MERAID_PRIVATE_KEY = var.some_value
      MERAID_BASE_URL = var.some_value
      MERAID_AUTH_ENDPOINT = var.some_value
      MERAID_COLLECT_ENDPOINT = var.some_value
      BASEFOLDER_PATH = var.some_value
      MAX_SIZE_LENGTH = var.some_value
      AWS_S3_BUCKET_NAME = var.some_value
      PRE_SIGN_EXPIRY_TIME = var.some_value
      EMAIL_EXPIRY = var.some_value
      RESET_PASSWORD_EXPIRY = var.some_value
      REJECT_PASS_AFTER_MERA_ID = var.some_value
      MERAID_APP_ID = var.some_value
      MERAID_REG_ID = var.some_value
      REJECT_PASS_AFTER_MERAID = var.some_value
      EMAIL_CHANGE_EXPIRY = var.some_value
      MERAID_SIGN_ENDPOINT = var.some_value
      NOTIFICATIONS_LIMIT = var.some_value
      APPS_EXPORT_NAME = var.some_value
    }
  }
  role = aws_iam_role.iam_role_lambda_execution.arn
}

resource "aws_lambda_function" "update_email_lambda_function" {
  code_signing_config_arn = {
    S3Bucket = "pk.jobapp.dev.us-east-1"
    S3Key = "serverless/backend/dev/1677757776022-2023-03-02T11:49:36.022Z/backend.zip"
  }
  handler = "s_updateEmail.handler"
  runtime = "nodejs14.x"
  function_name = "backend-dev-updateEmail"
  memory_size = 1024
  timeout = 6
  architectures = [
    "arm64"
  ]
  environment {
    variables = {
      IS_OFFLINE = var.is_offline
      REGION = var.region
      STAGE = var.stage
      DYNAMODB_MAIN_TABLE = var.DYNAMODB_MAIN
      JWT_SECRET = var.jwt_secret
      BACKEND_API_URL = var.some_value 
      FRONTEND_APP_URL = var.some_value
      PROJECT_NAME = var.some_value
      SOURCE_EMAIL = var.some_value
      REPLY_TO_ADDRESS = var.some_value
      MERAID_PRIVATE_KEY = var.some_value
      MERAID_BASE_URL = var.some_value
      MERAID_AUTH_ENDPOINT = var.some_value
      MERAID_COLLECT_ENDPOINT = var.some_value
      BASEFOLDER_PATH = var.some_value
      MAX_SIZE_LENGTH = var.some_value
      AWS_S3_BUCKET_NAME = var.some_value
      PRE_SIGN_EXPIRY_TIME = var.some_value
      EMAIL_EXPIRY = var.some_value
      RESET_PASSWORD_EXPIRY = var.some_value
      REJECT_PASS_AFTER_MERA_ID = var.some_value
      MERAID_APP_ID = var.some_value
      MERAID_REG_ID = var.some_value
      REJECT_PASS_AFTER_MERAID = var.some_value
      EMAIL_CHANGE_EXPIRY = var.some_value
      MERAID_SIGN_ENDPOINT = var.some_value
      NOTIFICATIONS_LIMIT = var.some_value
      APPS_EXPORT_NAME = var.some_value
    }
  }
  role = aws_iam_role.iam_role_lambda_execution.arn
}

resource "aws_lambda_function" "sign_up_lambda_function" {
  code_signing_config_arn = {
    S3Bucket = "pk.jobapp.dev.us-east-1"
    S3Key = "serverless/backend/dev/1677757776022-2023-03-02T11:49:36.022Z/backend.zip"
  }
  handler = "s_signUp.handler"
  runtime = "nodejs14.x"
  function_name = "backend-dev-signUp"
  memory_size = 1024
  timeout = 6
  architectures = [
    "arm64"
  ]
  environment {
    variables = {
      IS_OFFLINE = var.is_offline
      REGION = var.region
      STAGE = var.stage
      DYNAMODB_MAIN_TABLE = var.DYNAMODB_MAIN
      JWT_SECRET = var.jwt_secret
      BACKEND_API_URL = var.some_value 
      FRONTEND_APP_URL = var.some_value
      PROJECT_NAME = var.some_value
      SOURCE_EMAIL = var.some_value
      REPLY_TO_ADDRESS = var.some_value
      MERAID_PRIVATE_KEY = var.some_value
      MERAID_BASE_URL = var.some_value
      MERAID_AUTH_ENDPOINT = var.some_value
      MERAID_COLLECT_ENDPOINT = var.some_value
      BASEFOLDER_PATH = var.some_value
      MAX_SIZE_LENGTH = var.some_value
      AWS_S3_BUCKET_NAME = var.some_value
      PRE_SIGN_EXPIRY_TIME = var.some_value
      EMAIL_EXPIRY = var.some_value
      RESET_PASSWORD_EXPIRY = var.some_value
      REJECT_PASS_AFTER_MERA_ID = var.some_value
      MERAID_APP_ID = var.some_value
      MERAID_REG_ID = var.some_value
      REJECT_PASS_AFTER_MERAID = var.some_value
      EMAIL_CHANGE_EXPIRY = var.some_value
      MERAID_SIGN_ENDPOINT = var.some_value
      NOTIFICATIONS_LIMIT = var.some_value
      APPS_EXPORT_NAME = var.some_value
    }
  }
  role = aws_iam_role.sign_up_iam_role_lambda_execution.arn
}

resource "aws_lambda_function" "resend_email_lambda_function" {
  code_signing_config_arn = {
    S3Bucket = "pk.jobapp.dev.us-east-1"
    S3Key = "serverless/backend/dev/1677757776022-2023-03-02T11:49:36.022Z/backend.zip"
  }
  handler = "s_resendEmail.handler"
  runtime = "nodejs14.x"
  function_name = "backend-dev-resendEmail"
  memory_size = 1024
  timeout = 6
  architectures = [
    "arm64"
  ]
  environment {
    variables = {
      IS_OFFLINE = var.is_offline
      REGION = var.region
      STAGE = var.stage
      DYNAMODB_MAIN_TABLE = var.DYNAMODB_MAIN
      JWT_SECRET = var.jwt_secret
      BACKEND_API_URL = var.some_value 
      FRONTEND_APP_URL = var.some_value
      PROJECT_NAME = var.some_value
      SOURCE_EMAIL = var.some_value
      REPLY_TO_ADDRESS = var.some_value
      MERAID_PRIVATE_KEY = var.some_value
      MERAID_BASE_URL = var.some_value
      MERAID_AUTH_ENDPOINT = var.some_value
      MERAID_COLLECT_ENDPOINT = var.some_value
      BASEFOLDER_PATH = var.some_value
      MAX_SIZE_LENGTH = var.some_value
      AWS_S3_BUCKET_NAME = var.some_value
      PRE_SIGN_EXPIRY_TIME = var.some_value
      EMAIL_EXPIRY = var.some_value
      RESET_PASSWORD_EXPIRY = var.some_value
      REJECT_PASS_AFTER_MERA_ID = var.some_value
      MERAID_APP_ID = var.some_value
      MERAID_REG_ID = var.some_value
      REJECT_PASS_AFTER_MERAID = var.some_value
      EMAIL_CHANGE_EXPIRY = var.some_value
      MERAID_SIGN_ENDPOINT = var.some_value
      NOTIFICATIONS_LIMIT = var.some_value
      APPS_EXPORT_NAME = var.some_value
    }
  }
  role = aws_iam_role.resend_email_iam_role_lambda_execution.arn
}

resource "aws_lambda_function" "sign_in_lambda_function" {
  code_signing_config_arn = {
    S3Bucket = "pk.jobapp.dev.us-east-1"
    S3Key = "serverless/backend/dev/1677757776022-2023-03-02T11:49:36.022Z/backend.zip"
  }
  handler = "s_signIn.handler"
  runtime = "nodejs14.x"
  function_name = "backend-dev-signIn"
  memory_size = 1024
  timeout = 6
  architectures = [
    "arm64"
  ]
  environment {
    variables = {
      IS_OFFLINE = var.is_offline
      REGION = var.region
      STAGE = var.stage
      DYNAMODB_MAIN_TABLE = var.DYNAMODB_MAIN
      JWT_SECRET = var.jwt_secret
      BACKEND_API_URL = var.some_value 
      FRONTEND_APP_URL = var.some_value
      PROJECT_NAME = var.some_value
      SOURCE_EMAIL = var.some_value
      REPLY_TO_ADDRESS = var.some_value
      MERAID_PRIVATE_KEY = var.some_value
      MERAID_BASE_URL = var.some_value
      MERAID_AUTH_ENDPOINT = var.some_value
      MERAID_COLLECT_ENDPOINT = var.some_value
      BASEFOLDER_PATH = var.some_value
      MAX_SIZE_LENGTH = var.some_value
      AWS_S3_BUCKET_NAME = var.some_value
      PRE_SIGN_EXPIRY_TIME = var.some_value
      EMAIL_EXPIRY = var.some_value
      RESET_PASSWORD_EXPIRY = var.some_value
      REJECT_PASS_AFTER_MERA_ID = var.some_value
      MERAID_APP_ID = var.some_value
      MERAID_REG_ID = var.some_value
      REJECT_PASS_AFTER_MERAID = var.some_value
      EMAIL_CHANGE_EXPIRY = var.some_value
      MERAID_SIGN_ENDPOINT = var.some_value
      NOTIFICATIONS_LIMIT = var.some_value
      APPS_EXPORT_NAME = var.some_value
    }
  }
  role = aws_iam_role.iam_role_lambda_execution.arn
}

resource "aws_lambda_function" "login_with_mera_id_lambda_function" {
  code_signing_config_arn = {
    S3Bucket = "pk.jobapp.dev.us-east-1"
    S3Key = "serverless/backend/dev/1677757776022-2023-03-02T11:49:36.022Z/backend.zip"
  }
  handler = "s_loginWithMeraId.handler"
  runtime = "nodejs14.x"
  function_name = "backend-dev-loginWithMeraId"
  memory_size = 1024
  timeout = 6
  architectures = [
    "arm64"
  ]
  environment {
    variables = {
      IS_OFFLINE = var.is_offline
      REGION = var.region
      STAGE = var.stage
      DYNAMODB_MAIN_TABLE = var.DYNAMODB_MAIN
      JWT_SECRET = var.jwt_secret
      BACKEND_API_URL = var.some_value 
      FRONTEND_APP_URL = var.some_value
      PROJECT_NAME = var.some_value
      SOURCE_EMAIL = var.some_value
      REPLY_TO_ADDRESS = var.some_value
      MERAID_PRIVATE_KEY = var.some_value
      MERAID_BASE_URL = var.some_value
      MERAID_AUTH_ENDPOINT = var.some_value
      MERAID_COLLECT_ENDPOINT = var.some_value
      BASEFOLDER_PATH = var.some_value
      MAX_SIZE_LENGTH = var.some_value
      AWS_S3_BUCKET_NAME = var.some_value
      PRE_SIGN_EXPIRY_TIME = var.some_value
      EMAIL_EXPIRY = var.some_value
      RESET_PASSWORD_EXPIRY = var.some_value
      REJECT_PASS_AFTER_MERA_ID = var.some_value
      MERAID_APP_ID = var.some_value
      MERAID_REG_ID = var.some_value
      REJECT_PASS_AFTER_MERAID = var.some_value
      EMAIL_CHANGE_EXPIRY = var.some_value
      MERAID_SIGN_ENDPOINT = var.some_value
      NOTIFICATIONS_LIMIT = var.some_value
      APPS_EXPORT_NAME = var.some_value
    }
  }
  role = aws_iam_role.iam_role_lambda_execution.arn
}

resource "aws_lambda_function" "collect_mera_id_status_lambda_function" {
  code_signing_config_arn = {
    S3Bucket = "pk.jobapp.dev.us-east-1"
    S3Key = "serverless/backend/dev/1677757776022-2023-03-02T11:49:36.022Z/backend.zip"
  }
  handler = "s_collectMeraIdStatus.handler"
  runtime = "nodejs14.x"
  function_name = "backend-dev-collectMeraIdStatus"
  memory_size = 1024
  timeout = 6
  architectures = [
    "arm64"
  ]
  environment {
    variables = {
      IS_OFFLINE = var.is_offline
      REGION = var.region
      STAGE = var.stage
      DYNAMODB_MAIN_TABLE = var.DYNAMODB_MAIN
      JWT_SECRET = var.jwt_secret
      BACKEND_API_URL = var.some_value 
      FRONTEND_APP_URL = var.some_value
      PROJECT_NAME = var.some_value
      SOURCE_EMAIL = var.some_value
      REPLY_TO_ADDRESS = var.some_value
      MERAID_PRIVATE_KEY = var.some_value
      MERAID_BASE_URL = var.some_value
      MERAID_AUTH_ENDPOINT = var.some_value
      MERAID_COLLECT_ENDPOINT = var.some_value
      BASEFOLDER_PATH = var.some_value
      MAX_SIZE_LENGTH = var.some_value
      AWS_S3_BUCKET_NAME = var.some_value
      PRE_SIGN_EXPIRY_TIME = var.some_value
      EMAIL_EXPIRY = var.some_value
      RESET_PASSWORD_EXPIRY = var.some_value
      REJECT_PASS_AFTER_MERA_ID = var.some_value
      MERAID_APP_ID = var.some_value
      MERAID_REG_ID = var.some_value
      REJECT_PASS_AFTER_MERAID = var.some_value
      EMAIL_CHANGE_EXPIRY = var.some_value
      MERAID_SIGN_ENDPOINT = var.some_value
      NOTIFICATIONS_LIMIT = var.some_value
      APPS_EXPORT_NAME = var.some_value
    }
  }
  role = aws_iam_role.iam_role_lambda_execution.arn
}

resource "aws_lambda_function" "request_password_reset_lambda_function" {
  code_signing_config_arn = {
    S3Bucket = "pk.jobapp.dev.us-east-1"
    S3Key = "serverless/backend/dev/1677757776022-2023-03-02T11:49:36.022Z/backend.zip"
  }
  handler = "s_requestPasswordReset.handler"
  runtime = "nodejs14.x"
  function_name = "backend-dev-requestPasswordReset"
  memory_size = 1024
  timeout = 6
  architectures = [
    "arm64"
  ]
  environment {
    variables = {
      IS_OFFLINE = var.is_offline
      REGION = var.region
      STAGE = var.stage
      DYNAMODB_MAIN_TABLE = var.DYNAMODB_MAIN
      JWT_SECRET = var.jwt_secret
      BACKEND_API_URL = var.some_value 
      FRONTEND_APP_URL = var.some_value
      PROJECT_NAME = var.some_value
      SOURCE_EMAIL = var.some_value
      REPLY_TO_ADDRESS = var.some_value
      MERAID_PRIVATE_KEY = var.some_value
      MERAID_BASE_URL = var.some_value
      MERAID_AUTH_ENDPOINT = var.some_value
      MERAID_COLLECT_ENDPOINT = var.some_value
      BASEFOLDER_PATH = var.some_value
      MAX_SIZE_LENGTH = var.some_value
      AWS_S3_BUCKET_NAME = var.some_value
      PRE_SIGN_EXPIRY_TIME = var.some_value
      EMAIL_EXPIRY = var.some_value
      RESET_PASSWORD_EXPIRY = var.some_value
      REJECT_PASS_AFTER_MERA_ID = var.some_value
      MERAID_APP_ID = var.some_value
      MERAID_REG_ID = var.some_value
      REJECT_PASS_AFTER_MERAID = var.some_value
      EMAIL_CHANGE_EXPIRY = var.some_value
      MERAID_SIGN_ENDPOINT = var.some_value
      NOTIFICATIONS_LIMIT = var.some_value
      APPS_EXPORT_NAME = var.some_value
    }
  }
  role = aws_iam_role.request_password_reset_iam_role_lambda_execution.arn
}

resource "aws_lambda_function" "get_user_lambda_function" {
  code_signing_config_arn = {
    S3Bucket = "pk.jobapp.dev.us-east-1"
    S3Key = "serverless/backend/dev/1677757776022-2023-03-02T11:49:36.022Z/backend.zip"
  }
  handler = "s_getUser.handler"
  runtime = "nodejs14.x"
  function_name = "backend-dev-getUser"
  memory_size = 1024
  timeout = 6
  architectures = [
    "arm64"
  ]
  environment {
    variables = {
      IS_OFFLINE = var.is_offline
      REGION = var.region
      STAGE = var.stage
      DYNAMODB_MAIN_TABLE = var.DYNAMODB_MAIN
      JWT_SECRET = var.jwt_secret
      BACKEND_API_URL = var.some_value 
      FRONTEND_APP_URL = var.some_value
      PROJECT_NAME = var.some_value
      SOURCE_EMAIL = var.some_value
      REPLY_TO_ADDRESS = var.some_value
      MERAID_PRIVATE_KEY = var.some_value
      MERAID_BASE_URL = var.some_value
      MERAID_AUTH_ENDPOINT = var.some_value
      MERAID_COLLECT_ENDPOINT = var.some_value
      BASEFOLDER_PATH = var.some_value
      MAX_SIZE_LENGTH = var.some_value
      AWS_S3_BUCKET_NAME = var.some_value
      PRE_SIGN_EXPIRY_TIME = var.some_value
      EMAIL_EXPIRY = var.some_value
      RESET_PASSWORD_EXPIRY = var.some_value
      REJECT_PASS_AFTER_MERA_ID = var.some_value
      MERAID_APP_ID = var.some_value
      MERAID_REG_ID = var.some_value
      REJECT_PASS_AFTER_MERAID = var.some_value
      EMAIL_CHANGE_EXPIRY = var.some_value
      MERAID_SIGN_ENDPOINT = var.some_value
      NOTIFICATIONS_LIMIT = var.some_value
      APPS_EXPORT_NAME = var.some_value
    }
  }
  role = aws_iam_role.iam_role_lambda_execution.arn
}

resource "aws_lambda_function" "document_upload_lambda_function" {
  code_signing_config_arn = {
    S3Bucket = "pk.jobapp.dev.us-east-1"
    S3Key = "serverless/backend/dev/1677757776022-2023-03-02T11:49:36.022Z/backend.zip"
  }
  handler = "s_documentUpload.handler"
  runtime = "nodejs14.x"
  function_name = "backend-dev-documentUpload"
  memory_size = 1024
  timeout = 6
  architectures = [
    "arm64"
  ]
  environment {
    variables = {
      IS_OFFLINE = var.is_offline
      REGION = var.region
      STAGE = var.stage
      DYNAMODB_MAIN_TABLE = var.DYNAMODB_MAIN
      JWT_SECRET = var.jwt_secret
      BACKEND_API_URL = var.some_value 
      FRONTEND_APP_URL = var.some_value
      PROJECT_NAME = var.some_value
      SOURCE_EMAIL = var.some_value
      REPLY_TO_ADDRESS = var.some_value
      MERAID_PRIVATE_KEY = var.some_value
      MERAID_BASE_URL = var.some_value
      MERAID_AUTH_ENDPOINT = var.some_value
      MERAID_COLLECT_ENDPOINT = var.some_value
      BASEFOLDER_PATH = var.some_value
      MAX_SIZE_LENGTH = var.some_value
      AWS_S3_BUCKET_NAME = var.some_value
      PRE_SIGN_EXPIRY_TIME = var.some_value
      EMAIL_EXPIRY = var.some_value
      RESET_PASSWORD_EXPIRY = var.some_value
      REJECT_PASS_AFTER_MERA_ID = var.some_value
      MERAID_APP_ID = var.some_value
      MERAID_REG_ID = var.some_value
      REJECT_PASS_AFTER_MERAID = var.some_value
      EMAIL_CHANGE_EXPIRY = var.some_value
      MERAID_SIGN_ENDPOINT = var.some_value
      NOTIFICATIONS_LIMIT = var.some_value
      APPS_EXPORT_NAME = var.some_value
    }
  }
  role = aws_iam_role.document_upload_iam_role_lambda_execution.arn
}

resource "aws_lambda_function" "resume_personal_info_lambda_function" {
  code_signing_config_arn = {
    S3Bucket = "pk.jobapp.dev.us-east-1"
    S3Key = "serverless/backend/dev/1677757776022-2023-03-02T11:49:36.022Z/backend.zip"
  }
  handler = "s_resumePersonalInfo.handler"
  runtime = "nodejs14.x"
  function_name = "backend-dev-resumePersonalInfo"
  memory_size = 1024
  timeout = 6
  architectures = [
    "arm64"
  ]
  environment {
    variables = {
      IS_OFFLINE = var.is_offline
      REGION = var.region
      STAGE = var.stage
      DYNAMODB_MAIN_TABLE = var.DYNAMODB_MAIN
      JWT_SECRET = var.jwt_secret
      BACKEND_API_URL = var.some_value 
      FRONTEND_APP_URL = var.some_value
      PROJECT_NAME = var.some_value
      SOURCE_EMAIL = var.some_value
      REPLY_TO_ADDRESS = var.some_value
      MERAID_PRIVATE_KEY = var.some_value
      MERAID_BASE_URL = var.some_value
      MERAID_AUTH_ENDPOINT = var.some_value
      MERAID_COLLECT_ENDPOINT = var.some_value
      BASEFOLDER_PATH = var.some_value
      MAX_SIZE_LENGTH = var.some_value
      AWS_S3_BUCKET_NAME = var.some_value
      PRE_SIGN_EXPIRY_TIME = var.some_value
      EMAIL_EXPIRY = var.some_value
      RESET_PASSWORD_EXPIRY = var.some_value
      REJECT_PASS_AFTER_MERA_ID = var.some_value
      MERAID_APP_ID = var.some_value
      MERAID_REG_ID = var.some_value
      REJECT_PASS_AFTER_MERAID = var.some_value
      EMAIL_CHANGE_EXPIRY = var.some_value
      MERAID_SIGN_ENDPOINT = var.some_value
      NOTIFICATIONS_LIMIT = var.some_value
      APPS_EXPORT_NAME = var.some_value
    }
  }
  role = aws_iam_role.iam_role_lambda_execution.arn
}

resource "aws_lambda_function" "resume_continuation_lambda_function" {
  code_signing_config_arn = {
    S3Bucket = "pk.jobapp.dev.us-east-1"
    S3Key = "serverless/backend/dev/1677757776022-2023-03-02T11:49:36.022Z/backend.zip"
  }
  handler = "s_resumeContinuation.handler"
  runtime = "nodejs14.x"
  function_name = "backend-dev-resumeContinuation"
  memory_size = 1024
  timeout = 6
  architectures = [
    "arm64"
  ]
  environment {
    variables = {
      IS_OFFLINE = var.is_offline
      REGION = var.region
      STAGE = var.stage
      DYNAMODB_MAIN_TABLE = var.DYNAMODB_MAIN
      JWT_SECRET = var.jwt_secret
      BACKEND_API_URL = var.some_value 
      FRONTEND_APP_URL = var.some_value
      PROJECT_NAME = var.some_value
      SOURCE_EMAIL = var.some_value
      REPLY_TO_ADDRESS = var.some_value
      MERAID_PRIVATE_KEY = var.some_value
      MERAID_BASE_URL = var.some_value
      MERAID_AUTH_ENDPOINT = var.some_value
      MERAID_COLLECT_ENDPOINT = var.some_value
      BASEFOLDER_PATH = var.some_value
      MAX_SIZE_LENGTH = var.some_value
      AWS_S3_BUCKET_NAME = var.some_value
      PRE_SIGN_EXPIRY_TIME = var.some_value
      EMAIL_EXPIRY = var.some_value
      RESET_PASSWORD_EXPIRY = var.some_value
      REJECT_PASS_AFTER_MERA_ID = var.some_value
      MERAID_APP_ID = var.some_value
      MERAID_REG_ID = var.some_value
      REJECT_PASS_AFTER_MERAID = var.some_value
      EMAIL_CHANGE_EXPIRY = var.some_value
      MERAID_SIGN_ENDPOINT = var.some_value
      NOTIFICATIONS_LIMIT = var.some_value
      APPS_EXPORT_NAME = var.some_value
    }
  }
  role = aws_iam_role.iam_role_lambda_execution.arn
}

resource "aws_lambda_function" "job_details_lambda_function" {
  code_signing_config_arn = {
    S3Bucket = "pk.jobapp.dev.us-east-1"
    S3Key = "serverless/backend/dev/1677757776022-2023-03-02T11:49:36.022Z/backend.zip"
  }
  handler = "s_jobDetails.handler"
  runtime = "nodejs14.x"
  function_name = "backend-dev-jobDetails"
  memory_size = 1024
  timeout = 6
  architectures = [
    "arm64"
  ]
  environment {
    variables = {
      IS_OFFLINE = var.is_offline
      REGION = var.region
      STAGE = var.stage
      DYNAMODB_MAIN_TABLE = var.DYNAMODB_MAIN
      JWT_SECRET = var.jwt_secret
      BACKEND_API_URL = var.some_value 
      FRONTEND_APP_URL = var.some_value
      PROJECT_NAME = var.some_value
      SOURCE_EMAIL = var.some_value
      REPLY_TO_ADDRESS = var.some_value
      MERAID_PRIVATE_KEY = var.some_value
      MERAID_BASE_URL = var.some_value
      MERAID_AUTH_ENDPOINT = var.some_value
      MERAID_COLLECT_ENDPOINT = var.some_value
      BASEFOLDER_PATH = var.some_value
      MAX_SIZE_LENGTH = var.some_value
      AWS_S3_BUCKET_NAME = var.some_value
      PRE_SIGN_EXPIRY_TIME = var.some_value
      EMAIL_EXPIRY = var.some_value
      RESET_PASSWORD_EXPIRY = var.some_value
      REJECT_PASS_AFTER_MERA_ID = var.some_value
      MERAID_APP_ID = var.some_value
      MERAID_REG_ID = var.some_value
      REJECT_PASS_AFTER_MERAID = var.some_value
      EMAIL_CHANGE_EXPIRY = var.some_value
      MERAID_SIGN_ENDPOINT = var.some_value
      NOTIFICATIONS_LIMIT = var.some_value
      APPS_EXPORT_NAME = var.some_value
    }
  }
  role = aws_iam_role.iam_role_lambda_execution.arn
}

resource "aws_lambda_function" "apply_for_job_lambda_function" {
  code_signing_config_arn = {
    S3Bucket = "pk.jobapp.dev.us-east-1"
    S3Key = "serverless/backend/dev/1677757776022-2023-03-02T11:49:36.022Z/backend.zip"
  }
  handler = "s_applyForJob.handler"
  runtime = "nodejs14.x"
  function_name = "backend-dev-applyForJob"
  memory_size = 1024
  timeout = 6
  architectures = [
    "arm64"
  ]
  environment {
    variables = {
      IS_OFFLINE = var.is_offline
      REGION = var.region
      STAGE = var.stage
      DYNAMODB_MAIN_TABLE = var.DYNAMODB_MAIN
      JWT_SECRET = var.jwt_secret
      BACKEND_API_URL = var.some_value 
      FRONTEND_APP_URL = var.some_value
      PROJECT_NAME = var.some_value
      SOURCE_EMAIL = var.some_value
      REPLY_TO_ADDRESS = var.some_value
      MERAID_PRIVATE_KEY = var.some_value
      MERAID_BASE_URL = var.some_value
      MERAID_AUTH_ENDPOINT = var.some_value
      MERAID_COLLECT_ENDPOINT = var.some_value
      BASEFOLDER_PATH = var.some_value
      MAX_SIZE_LENGTH = var.some_value
      AWS_S3_BUCKET_NAME = var.some_value
      PRE_SIGN_EXPIRY_TIME = var.some_value
      EMAIL_EXPIRY = var.some_value
      RESET_PASSWORD_EXPIRY = var.some_value
      REJECT_PASS_AFTER_MERA_ID = var.some_value
      MERAID_APP_ID = var.some_value
      MERAID_REG_ID = var.some_value
      REJECT_PASS_AFTER_MERAID = var.some_value
      EMAIL_CHANGE_EXPIRY = var.some_value
      MERAID_SIGN_ENDPOINT = var.some_value
      NOTIFICATIONS_LIMIT = var.some_value
      APPS_EXPORT_NAME = var.some_value
    }
  }
  role = aws_iam_role.iam_role_lambda_execution.arn
}

resource "aws_lambda_function" "apply_via_mera_id_lambda_function" {
  code_signing_config_arn = {
    S3Bucket = "pk.jobapp.dev.us-east-1"
    S3Key = "serverless/backend/dev/1677757776022-2023-03-02T11:49:36.022Z/backend.zip"
  }
  handler = "s_applyViaMeraID.handler"
  runtime = "nodejs14.x"
  function_name = "backend-dev-applyViaMeraID"
  memory_size = 1024
  timeout = 6
  architectures = [
    "arm64"
  ]
  environment {
    variables = {
      IS_OFFLINE = var.is_offline
      REGION = var.region
      STAGE = var.stage
      DYNAMODB_MAIN_TABLE = var.DYNAMODB_MAIN
      JWT_SECRET = var.jwt_secret
      BACKEND_API_URL = var.some_value 
      FRONTEND_APP_URL = var.some_value
      PROJECT_NAME = var.some_value
      SOURCE_EMAIL = var.some_value
      REPLY_TO_ADDRESS = var.some_value
      MERAID_PRIVATE_KEY = var.some_value
      MERAID_BASE_URL = var.some_value
      MERAID_AUTH_ENDPOINT = var.some_value
      MERAID_COLLECT_ENDPOINT = var.some_value
      BASEFOLDER_PATH = var.some_value
      MAX_SIZE_LENGTH = var.some_value
      AWS_S3_BUCKET_NAME = var.some_value
      PRE_SIGN_EXPIRY_TIME = var.some_value
      EMAIL_EXPIRY = var.some_value
      RESET_PASSWORD_EXPIRY = var.some_value
      REJECT_PASS_AFTER_MERA_ID = var.some_value
      MERAID_APP_ID = var.some_value
      MERAID_REG_ID = var.some_value
      REJECT_PASS_AFTER_MERAID = var.some_value
      EMAIL_CHANGE_EXPIRY = var.some_value
      MERAID_SIGN_ENDPOINT = var.some_value
      NOTIFICATIONS_LIMIT = var.some_value
      APPS_EXPORT_NAME = var.some_value
    }
  }
  role = aws_iam_role.iam_role_lambda_execution.arn
}

resource "aws_lambda_function" "apply_via_mera_id_status_lambda_function" {
  code_signing_config_arn = {
    S3Bucket = "pk.jobapp.dev.us-east-1"
    S3Key = "serverless/backend/dev/1677757776022-2023-03-02T11:49:36.022Z/backend.zip"
  }
  handler = "s_applyViaMeraIDStatus.handler"
  runtime = "nodejs14.x"
  function_name = "backend-dev-applyViaMeraIDStatus"
  memory_size = 1024
  timeout = 6
  architectures = [
    "arm64"
  ]
  environment {
    variables = {
      IS_OFFLINE = var.is_offline
      REGION = var.region
      STAGE = var.stage
      DYNAMODB_MAIN_TABLE = var.DYNAMODB_MAIN
      JWT_SECRET = var.jwt_secret
      BACKEND_API_URL = var.some_value 
      FRONTEND_APP_URL = var.some_value
      PROJECT_NAME = var.some_value
      SOURCE_EMAIL = var.some_value
      REPLY_TO_ADDRESS = var.some_value
      MERAID_PRIVATE_KEY = var.some_value
      MERAID_BASE_URL = var.some_value
      MERAID_AUTH_ENDPOINT = var.some_value
      MERAID_COLLECT_ENDPOINT = var.some_value
      BASEFOLDER_PATH = var.some_value
      MAX_SIZE_LENGTH = var.some_value
      AWS_S3_BUCKET_NAME = var.some_value
      PRE_SIGN_EXPIRY_TIME = var.some_value
      EMAIL_EXPIRY = var.some_value
      RESET_PASSWORD_EXPIRY = var.some_value
      REJECT_PASS_AFTER_MERA_ID = var.some_value
      MERAID_APP_ID = var.some_value
      MERAID_REG_ID = var.some_value
      REJECT_PASS_AFTER_MERAID = var.some_value
      EMAIL_CHANGE_EXPIRY = var.some_value
      MERAID_SIGN_ENDPOINT = var.some_value
      NOTIFICATIONS_LIMIT = var.some_value
      APPS_EXPORT_NAME = var.some_value
    }
  }
  role = aws_iam_role.iam_role_lambda_execution.arn
}

resource "aws_lambda_function" "get_resume_lambda_function" {
  code_signing_config_arn = {
    S3Bucket = "pk.jobapp.dev.us-east-1"
    S3Key = "serverless/backend/dev/1677757776022-2023-03-02T11:49:36.022Z/backend.zip"
  }
  handler = "s_getResume.handler"
  runtime = "nodejs14.x"
  function_name = "backend-dev-getResume"
  memory_size = 1024
  timeout = 6
  architectures = [
    "arm64"
  ]
  environment {
    variables = {
      IS_OFFLINE = var.is_offline
      REGION = var.region
      STAGE = var.stage
      DYNAMODB_MAIN_TABLE = var.DYNAMODB_MAIN
      JWT_SECRET = var.jwt_secret
      BACKEND_API_URL = var.some_value 
      FRONTEND_APP_URL = var.some_value
      PROJECT_NAME = var.some_value
      SOURCE_EMAIL = var.some_value
      REPLY_TO_ADDRESS = var.some_value
      MERAID_PRIVATE_KEY = var.some_value
      MERAID_BASE_URL = var.some_value
      MERAID_AUTH_ENDPOINT = var.some_value
      MERAID_COLLECT_ENDPOINT = var.some_value
      BASEFOLDER_PATH = var.some_value
      MAX_SIZE_LENGTH = var.some_value
      AWS_S3_BUCKET_NAME = var.some_value
      PRE_SIGN_EXPIRY_TIME = var.some_value
      EMAIL_EXPIRY = var.some_value
      RESET_PASSWORD_EXPIRY = var.some_value
      REJECT_PASS_AFTER_MERA_ID = var.some_value
      MERAID_APP_ID = var.some_value
      MERAID_REG_ID = var.some_value
      REJECT_PASS_AFTER_MERAID = var.some_value
      EMAIL_CHANGE_EXPIRY = var.some_value
      MERAID_SIGN_ENDPOINT = var.some_value
      NOTIFICATIONS_LIMIT = var.some_value
      APPS_EXPORT_NAME = var.some_value
    }
  }
  role = aws_iam_role.get_resume_iam_role_lambda_execution.arn
}

resource "aws_lambda_function" "get_job_app_hist_lambda_function" {
  code_signing_config_arn = {
    S3Bucket = "pk.jobapp.dev.us-east-1"
    S3Key = "serverless/backend/dev/1677757776022-2023-03-02T11:49:36.022Z/backend.zip"
  }
  handler = "s_getJobAppHist.handler"
  runtime = "nodejs14.x"
  function_name = "backend-dev-getJobAppHist"
  memory_size = 1024
  timeout = 6
  architectures = [
    "arm64"
  ]
  environment {
    variables = {
      IS_OFFLINE = var.is_offline
      REGION = var.region
      STAGE = var.stage
      DYNAMODB_MAIN_TABLE = var.DYNAMODB_MAIN
      JWT_SECRET = var.jwt_secret
      BACKEND_API_URL = var.some_value 
      FRONTEND_APP_URL = var.some_value
      PROJECT_NAME = var.some_value
      SOURCE_EMAIL = var.some_value
      REPLY_TO_ADDRESS = var.some_value
      MERAID_PRIVATE_KEY = var.some_value
      MERAID_BASE_URL = var.some_value
      MERAID_AUTH_ENDPOINT = var.some_value
      MERAID_COLLECT_ENDPOINT = var.some_value
      BASEFOLDER_PATH = var.some_value
      MAX_SIZE_LENGTH = var.some_value
      AWS_S3_BUCKET_NAME = var.some_value
      PRE_SIGN_EXPIRY_TIME = var.some_value
      EMAIL_EXPIRY = var.some_value
      RESET_PASSWORD_EXPIRY = var.some_value
      REJECT_PASS_AFTER_MERA_ID = var.some_value
      MERAID_APP_ID = var.some_value
      MERAID_REG_ID = var.some_value
      REJECT_PASS_AFTER_MERAID = var.some_value
      EMAIL_CHANGE_EXPIRY = var.some_value
      MERAID_SIGN_ENDPOINT = var.some_value
      NOTIFICATIONS_LIMIT = var.some_value
      APPS_EXPORT_NAME = var.some_value
    }
  }
  role = aws_iam_role.iam_role_lambda_execution.arn
}

resource "aws_lambda_function" "get_job_app_detail_lambda_function" {
  code_signing_config_arn = {
    S3Bucket = "pk.jobapp.dev.us-east-1"
    S3Key = "serverless/backend/dev/1677757776022-2023-03-02T11:49:36.022Z/backend.zip"
  }
  handler = "s_getJobAppDetail.handler"
  runtime = "nodejs14.x"
  function_name = "backend-dev-getJobAppDetail"
  memory_size = 1024
  timeout = 6
  architectures = [
    "arm64"
  ]
  environment {
    variables = {
      IS_OFFLINE = var.is_offline
      REGION = var.region
      STAGE = var.stage
      DYNAMODB_MAIN_TABLE = var.DYNAMODB_MAIN
      JWT_SECRET = var.jwt_secret
      BACKEND_API_URL = var.some_value 
      FRONTEND_APP_URL = var.some_value
      PROJECT_NAME = var.some_value
      SOURCE_EMAIL = var.some_value
      REPLY_TO_ADDRESS = var.some_value
      MERAID_PRIVATE_KEY = var.some_value
      MERAID_BASE_URL = var.some_value
      MERAID_AUTH_ENDPOINT = var.some_value
      MERAID_COLLECT_ENDPOINT = var.some_value
      BASEFOLDER_PATH = var.some_value
      MAX_SIZE_LENGTH = var.some_value
      AWS_S3_BUCKET_NAME = var.some_value
      PRE_SIGN_EXPIRY_TIME = var.some_value
      EMAIL_EXPIRY = var.some_value
      RESET_PASSWORD_EXPIRY = var.some_value
      REJECT_PASS_AFTER_MERA_ID = var.some_value
      MERAID_APP_ID = var.some_value
      MERAID_REG_ID = var.some_value
      REJECT_PASS_AFTER_MERAID = var.some_value
      EMAIL_CHANGE_EXPIRY = var.some_value
      MERAID_SIGN_ENDPOINT = var.some_value
      NOTIFICATIONS_LIMIT = var.some_value
      APPS_EXPORT_NAME = var.some_value
    }
  }
  role = aws_iam_role.iam_role_lambda_execution.arn
}
