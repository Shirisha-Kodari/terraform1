resource "aws_acm_certificate" "daws84s" {
  domain_name       = "*.${var.zone_name}"
  validation_method = "DNS"

  tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}"
    }
  )

  lifecycle { #when you chnage the ec2 udate,ec2,sg then terraform will first create the new instance,delete the old ec2
    create_before_destroy = true
  }
}

resource "aws_route53_record" "daws84s" {
  for_each = {
    for dvo in aws_acm_certificate.daws84s.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
      
    }
  }
  
  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = var.zone_id
}

resource "aws_acm_certificate_validation" "daws84s" {
  certificate_arn         = aws_acm_certificate.daws84s.arn
  validation_record_fqdns = [for record in aws_route53_record.daws84s : record.fqdn]
}

#ssl/tls added to frontend load balnacer https port:443 