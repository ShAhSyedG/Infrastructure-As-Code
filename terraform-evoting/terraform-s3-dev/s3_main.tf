terraform {
  backend "s3" {
    bucket         = "terrafrom-state-elections-site" 
    key            = "01-elections/frontend/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-locking"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "elections_frontend" {
  bucket = "dev-elections-frontend"
  force_destroy = true
}


resource "aws_s3_bucket_versioning" "elections_frontend_versioning" {
  bucket = aws_s3_bucket.elections_frontend.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "elections_frontend_crypto_conf" {
  bucket = aws_s3_bucket.elections_frontend.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}


resource "aws_s3_bucket_ownership_controls" "elections_frontend_ownership" {
  bucket = aws_s3_bucket.elections_frontend.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

#resource "aws_s3_bucket_website_configuration" "elections_frontend_static_hosting" {
#  bucket = aws_s3_bucket.elections_frontend.id
#  index_document {
#    suffix = "index.html"
#  }
#  error_document {
#    key = "index.html"
#  }
#}

resource "aws_s3_bucket_public_access_block" "elections_frontend_access" {
  bucket = aws_s3_bucket.elections_frontend.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "elections_frontend_acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.elections_frontend_ownership,
    aws_s3_bucket_public_access_block.elections_frontend_access,
  ]

  bucket = aws_s3_bucket.elections_frontend.id
  acl    = "public-read"
}

resource "aws_s3_bucket_policy" "elections_frontend_policy" {
  bucket = aws_s3_bucket.elections_frontend.id # Replace with your bucket name
  depends_on = [aws_s3_bucket.elections_frontend]

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "MYBUCKETPOLICY"
    Statement = [
      {
        Sid       = "IPAllow"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.elections_frontend.arn}/*"
      }
    ]
  })
}
#############################################################################
#############################################################################
resource "aws_s3_bucket" "elections_frontend_1" {
  bucket = "dev-elections-frontend-1"
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "elections_frontend_1_versioning" {
  bucket = aws_s3_bucket.elections_frontend_1.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "elections_frontend_1_crypto_conf" {
  bucket = aws_s3_bucket.elections_frontend_1.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_ownership_controls" "elections_frontend_1_ownership" {
  bucket = aws_s3_bucket.elections_frontend_1.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

#resource "aws_s3_bucket_website_configuration" "elections_frontend_1_static_hosting" {
#  bucket = aws_s3_bucket.elections_frontend_1.id
#  index_document {
#    suffix = "index.html"
#  }
#  error_document {
#    key = "index.html"
#  }
#}

resource "aws_s3_bucket_public_access_block" "elections_frontend_1_access" {
  bucket = aws_s3_bucket.elections_frontend_1.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "elections_frontend_1_acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.elections_frontend_1_ownership,
    aws_s3_bucket_public_access_block.elections_frontend_1_access,
  ]

  bucket = aws_s3_bucket.elections_frontend_1.id
  acl    = "public-read"
}

resource "aws_s3_bucket_policy" "elections_frontend_1_policy" {
  bucket = aws_s3_bucket.elections_frontend_1.id

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "MYBUCKETPOLICY"
    Statement = [
      {
        Sid       = "IPAllow"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.elections_frontend_1.arn}/*"
      }
    ]
  })
}

resource "aws_s3_bucket" "elections_frontend_2" {
  bucket = "dev-elections-frontend-2"
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "elections_frontend_2_versioning" {
  bucket = aws_s3_bucket.elections_frontend_2.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "elections_frontend_2_crypto_conf" {
  bucket = aws_s3_bucket.elections_frontend_2.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_ownership_controls" "elections_frontend_2_ownership" {
  bucket = aws_s3_bucket.elections_frontend_2.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

#resource "aws_s3_bucket_website_configuration" "elections_frontend_2_static_hosting" {
#  bucket = aws_s3_bucket.elections_frontend_2.id
#  index_document {
#    suffix = "index.html"
#  }
#  error_document {
#    key = "index.html"
#  }
#}

resource "aws_s3_bucket_public_access_block" "elections_frontend_2_access" {
  bucket = aws_s3_bucket.elections_frontend_2.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "elections_frontend_2_acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.elections_frontend_2_ownership,
    aws_s3_bucket_public_access_block.elections_frontend_2_access,
  ]

  bucket = aws_s3_bucket.elections_frontend_2.id
  acl    = "public-read"
}

resource "aws_s3_bucket_policy" "elections_frontend_2_policy" {
  bucket = aws_s3_bucket.elections_frontend_2.id

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "MYBUCKETPOLICY"
    Statement = [
      {
        Sid       = "IPAllow"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.elections_frontend_2.arn}/*"
      }
    ]
  })
}

resource "aws_s3_bucket" "elections_frontend_3" {
  bucket = "dev-elections-frontend-3"
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "elections_frontend_3_versioning" {
  bucket = aws_s3_bucket.elections_frontend_3.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "elections_frontend_3_crypto_conf" {
  bucket = aws_s3_bucket.elections_frontend_3.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_ownership_controls" "elections_frontend_3_ownership" {
  bucket = aws_s3_bucket.elections_frontend_3.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

#resource "aws_s3_bucket_website_configuration" "elections_frontend_3_static_hosting" {
#  bucket = aws_s3_bucket.elections_frontend_3.id
#  index_document {
#    suffix = "index.html"
#  }
#  error_document {
#    key = "index.html"
#  }
#}

resource "aws_s3_bucket_public_access_block" "elections_frontend_3_access" {
  bucket = aws_s3_bucket.elections_frontend_3.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "elections_frontend_3_acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.elections_frontend_3_ownership,
    aws_s3_bucket_public_access_block.elections_frontend_3_access,
  ]

  bucket = aws_s3_bucket.elections_frontend_3.id
  acl    = "public-read"
}

resource "aws_s3_bucket_policy" "elections_frontend_3_policy" {
  bucket = aws_s3_bucket.elections_frontend_3.id

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "MYBUCKETPOLICY"
    Statement = [
      {
        Sid       = "IPAllow"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.elections_frontend_3.arn}/*"
      }
    ]
  })
}