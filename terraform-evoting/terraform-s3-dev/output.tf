output "bucket_name" {
  value = aws_s3_bucket.elections_frontend.bucket
  description = "Dev Bucket"
}

output "bucket_arn" {
  value = aws_s3_bucket.elections_frontend.arn
  description = "Dev Bucket ARN"
}

output "bucket_name_1" {
  value = aws_s3_bucket.elections_frontend_1.bucket
  description = "Dev Bucket"
}

output "bucket_arn_1" {
  value = aws_s3_bucket.elections_frontend_1.arn
  description = "Dev Bucket ARN"
}

output "bucket_name_2" {
  value = aws_s3_bucket.elections_frontend_2.bucket
  description = "Dev Bucket"
}

output "bucket_arn_2" {
  value = aws_s3_bucket.elections_frontend_2.arn
  description = "Dev Bucket ARN"
}

output "bucket_name_3" {
  value = aws_s3_bucket.elections_frontend_3.bucket
  description = "Dev Bucket"
}

output "bucket_arn_3" {
  value = aws_s3_bucket.elections_frontend_3.arn
  description = "Dev Bucket ARN"
}

output "cf_domain_name" {
  description = "The domain name of the CloudFront distribution"
  value = aws_cloudfront_distribution.s3_distribution.domain_name
}
