module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 2.0"

  zone_id = module.zones.this_route53_zone_zone_id["${var.app_prefix}.com"]

  domain_name               = "${var.app_prefix}.com"
  subject_alternative_names = ["*.${var.app_prefix}.com"]

  wait_for_validation = false
}
