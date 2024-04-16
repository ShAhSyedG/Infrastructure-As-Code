resource "aws_cloudfront_distribution" "s3_distribution" {
    aliases = [
        "dev1.domain.com"
    ]
    origin {
        custom_origin_config {
            http_port = 80
            https_port = 443
            origin_keepalive_timeout = 5
            origin_protocol_policy = "http-only"
            origin_read_timeout = 30
            origin_ssl_protocols = [
                "TLSv1",
                "TLSv1.1",
                "TLSv1.2"
            ]
        }
        domain_name = "dev-elections-frontend.s3-website-us-east-1.amazonaws.com"
        origin_id = "Elections Site Dev1"
        
        origin_path = ""
    }

  default_cache_behavior {
    target_origin_id = "Elections Site Dev1"

    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    trusted_signers  = []

    viewer_protocol_policy = "allow-all"
    compress = true
    smooth_streaming  = false
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400

    
    forwarded_values {
      query_string = false
      
      cookies {
        forward = "all"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
    comment = ""
    price_class = "PriceClass_All"
    enabled = true

  viewer_certificate {
      acm_certificate_arn = "aws_certificate_arn"
      cloudfront_default_certificate = false
      minimum_protocol_version = "TLSv1.2_2021"
      ssl_support_method = "sni-only"
  }
  http_version = "http2"
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  tags = {
    Environment = "production"
  }

}

resource "aws_cloudfront_distribution" "elections_dev1_distribution" {
    aliases = [
        "dev2.domain.com"
    ]
    origin {
        custom_origin_config {
            http_port = 80
            https_port = 443
            origin_keepalive_timeout = 5
            origin_protocol_policy = "http-only"
            origin_read_timeout = 30
            origin_ssl_protocols = [
                "TLSv1",
                "TLSv1.1",
                "TLSv1.2"
            ]
        }
        domain_name = "dev-elections-frontend-1.s3-website-us-east-1.amazonaws.com"
        origin_id = "Elections Site Dev2"
        
        origin_path = ""
    }

  default_cache_behavior {
    target_origin_id = "Elections Site Dev2"

    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    trusted_signers  = []

    viewer_protocol_policy = "allow-all"
    compress = true
    smooth_streaming  = false
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400

    
    forwarded_values {
      query_string = false
      
      cookies {
        forward = "all"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
    comment = ""
    price_class = "PriceClass_All"
    enabled = true

  viewer_certificate {
      acm_certificate_arn = "aws_certificate_arn"
      cloudfront_default_certificate = false
      minimum_protocol_version = "TLSv1.2_2021"
      ssl_support_method = "sni-only"
  }
  http_version = "http2"
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  tags = {
    Environment = "production"
  }

}

resource "aws_cloudfront_distribution" "elections_dev2_distribution" {
    aliases = [
        "dev3.domain.com"
    ]
    origin {
        custom_origin_config {
            http_port = 80
            https_port = 443
            origin_keepalive_timeout = 5
            origin_protocol_policy = "http-only"
            origin_read_timeout = 30
            origin_ssl_protocols = [
                "TLSv1",
                "TLSv1.1",
                "TLSv1.2"
            ]
        }
        domain_name = "dev-elections-frontend-2.s3-website-us-east-1.amazonaws.com"
        origin_id = "Elections Site Dev3"
        
        origin_path = ""
    }

  default_cache_behavior {
    target_origin_id = "Elections Site Dev3"

    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    trusted_signers  = []

    viewer_protocol_policy = "allow-all"
    compress = true
    smooth_streaming  = false
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400

    
    forwarded_values {
      query_string = false
      
      cookies {
        forward = "all"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
    comment = ""
    price_class = "PriceClass_All"
    enabled = true

  viewer_certificate {
      acm_certificate_arn = "aws_certificate_arn"
      cloudfront_default_certificate = false
      minimum_protocol_version = "TLSv1.2_2021"
      ssl_support_method = "sni-only"
  }
  http_version = "http2"
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  tags = {
    Environment = "production"
  }

}

resource "aws_cloudfront_distribution" "elections_dev3_distribution" {
    aliases = [
        "dev4.domain.com"
    ]
    origin {
        custom_origin_config {
            http_port = 80
            https_port = 443
            origin_keepalive_timeout = 5
            origin_protocol_policy = "http-only"
            origin_read_timeout = 30
            origin_ssl_protocols = [
                "TLSv1",
                "TLSv1.1",
                "TLSv1.2"
            ]
        }
        domain_name = "dev-elections-frontend-3.s3-website-us-east-1.amazonaws.com"
        origin_id = "Elections Site Dev4"
        
        origin_path = ""
    }

  default_cache_behavior {
    target_origin_id = "Elections Site Dev4"

    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    trusted_signers  = []

    viewer_protocol_policy = "allow-all"
    compress = true
    smooth_streaming  = false
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400

    
    forwarded_values {
      query_string = false
      
      cookies {
        forward = "all"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
    comment = ""
    price_class = "PriceClass_All"
    enabled = true

  viewer_certificate {
      acm_certificate_arn = "aws_certificate_arn"
      cloudfront_default_certificate = false
      minimum_protocol_version = "TLSv1.2_2021"
      ssl_support_method = "sni-only"
  }
  http_version = "http2"
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  tags = {
    Environment = "production"
  }

}