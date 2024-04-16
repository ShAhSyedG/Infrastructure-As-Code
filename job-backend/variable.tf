variable "protcol" {
  description = "Job App env variable"
  type        = string
  sensitive   = true
}

variable "is_offline" {
  description = "Job App env variable"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "Default region for Job App"
  type        = string
  sensitive   = true
}

variable "stage" {
  description = "Job App Staging env"
  type        = string
  sensitive   = true
}

variable "jwt_secret" {
  description = "JWT secret for Job App"
  type        = string
  sensitive   = true
}

variable "DYNAMODB_MAIN" {
  description = "JWT secret for Job App"
  type        = string
  sensitive   = true
}
