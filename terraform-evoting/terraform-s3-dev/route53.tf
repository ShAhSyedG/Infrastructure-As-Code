#resource "aws_route53_zone" "Route53HostedZone" {
#    name = "domain.com."
#}


resource "aws_route53_record" "Route53RecordSet6" {
    name = "dev1.domain.com."
    type = "A"
    alias {
        name = aws_cloudfront_distribution.s3_distribution.domain_name
        zone_id = "sadsadfasfadfad"
        evaluate_target_health = false
    }
    zone_id = "sadsadfasfadfad"
}

resource "aws_route53_record" "Route53RecordSet7" {
    name = "dev2.domain.com."
    type = "A"
    alias {
        name = aws_cloudfront_distribution.elections_dev1_distribution.domain_name
        zone_id = "sadsadfasfadfad"
        evaluate_target_health = false
    }
    zone_id = "sadsadfasfadfad"
}

resource "aws_route53_record" "Route53RecordSet8" {
    name = "dev3.domain.com."
    type = "A"
    alias {
        name = aws_cloudfront_distribution.elections_dev2_distribution.domain_name
        zone_id = "sadsadfasfadfad"
        evaluate_target_health = false
    }
    zone_id = "sadsadfasfadfad"
}

resource "aws_route53_record" "Route53RecordSet9" {
    name = "dev4.domain.com."
    type = "A"
    alias {
        name = aws_cloudfront_distribution.elections_dev3_distribution.domain_name
        zone_id = "sadsadfasfadfad"
        evaluate_target_health = false
    }
    zone_id = "sadsadfasfadfad"
}