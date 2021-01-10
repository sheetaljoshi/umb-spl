output "elb_name" {
  description = "The name of the ELB"
  value       = module.elb.this_elb_name
}

output "elb_dns_name" {
  description = "The DNS name of the ELB"
  value       = module.elb.this_elb_dns_name
}

output "elb_zone_id" {
  description = "The canonical hosted zone ID of the ELB (to be used in a Route 53 Alias record)"
  value       = module.elb.this_elb_zone_id
}
