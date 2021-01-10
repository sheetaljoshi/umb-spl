module "zones" {
  count = "${var.domain_name == "" ? 0 : 1}"
  source = "terraform-aws-modules/route53/aws//modules/zones"
  version = "~> 1.0"

  zones = {
    "${var.domain_name}" = {
      comment = "${var.app_prefix} Domain Name"
      tags = {
        Customer    = var.customer
        Environment = var.environment
      }
    }

  }
}

module "records" {
  count = "${var.domain_name == "" ? 0 : 1}"
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "~> 1.0"
  #zone_id = module.zones.this_route53_zone_zone_id["${var.app_prefix}.com"]
  zone_name = module.zones ? keys(module.zones.this_route53_zone_zone_id)[0] : ""
  
  records = [
    {
      name = "static"
      type = "A"
      alias = {
        name                   = module.elb.this_elb_dns_name
        zone_id                = module.elb.this_elb_zone_id
        evaluate_target_health = true
      }

      tags = {
        Customer    = var.customer
        Environment = var.environment
      }
    }
  ]
  depends_on = [module.zones]
}
