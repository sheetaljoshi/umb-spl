module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 2.0"

  zone_id = aws_route53_zone.static.zone_id

  domain_name               = "${var.app_prefix}.com"
  subject_alternative_names = ["*.${var.app_prefix}.com"]

  wait_for_validation = false
}
