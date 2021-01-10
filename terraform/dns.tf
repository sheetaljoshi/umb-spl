module "zones" {
  source = "terraform-aws-modules/route53/aws//modules/zones"
  version = "~> 1.0"

  zones = {
    "${var.app_prefix}.com" = {
      comment = "${var.app_prefix}.com"
      tags = {
        Customer    = "${var.customer}"
        Environment = "${var.environment}"
      }
    }

  }
}

module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "~> 1.0"
  zone_id = module.zones.this_route53_zone_zone_id["${var.app_prefix}.com"]

  records = [
    {

      alias = {
        name                   = module.elb.this_elb_dns_name
        zone_id                = module.elb.this_elb_zone_id
        evaluate_target_health = true
      }

      tags = {
        Customer    = "${var.customer}"
        Environment = "${var.environment}"
      }
    }
  ]
}
