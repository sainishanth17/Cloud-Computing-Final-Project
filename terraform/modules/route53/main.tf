resource "aws_acm_certificate" "racistzebra" {
  domain_name = "${var.subdomain_name}.${var.domain_name}"
  validation_method = "DNS"
}

resource "aws_route53_zone" "racistzebra" {
  name = var.domain_name
}

resource "aws_route53_record" "validation" {
  for_each = {
    for dvo in aws_acm_certificate.racistzebra.domain_validation_options : dvo.domain_name => {
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
  zone_id         = aws_route53_zone.racistzebra.zone_id
}


resource "aws_acm_certificate_validation" "racistzebra" {
  certificate_arn = aws_acm_certificate.racistzebra.arn
  validation_record_fqdns = [for record in aws_route53_record.validation : record.fqdn]
}
resource "aws_route53_record" "subdomain" {
  zone_id = aws_route53_zone.racistzebra.zone_id
  name    = var.subdomain_name
  type    = "A"
  alias {
    name = var.alb_hostname
    zone_id = var.alb_zone_id
    evaluate_target_health = true
  }
}