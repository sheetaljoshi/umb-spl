module "acm" {
  count = var.domain_name == "" ? 0 : 1
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 2.0"

  zone_id = module.zones ? module.zones.this_route53_zone_zone_id[var.domain_name]: ""

  domain_name               = var.domain_name
  subject_alternative_names = ["${var.app_prefix}.${var.domain_name}", "*.${var.app_prefix}.${var.domain_name}"]

  wait_for_validation = true
}
