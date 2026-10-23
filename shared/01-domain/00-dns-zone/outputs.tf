output "zone_id" {
  description = "Route53 Zone ID"
  value       = aws_route53_zone.this.zone_id
}

output "domain_name" {
  description = "Domain Name"
  value       = aws_route53_zone.this.name
}

output "name_servers" {
  description = "Name servers of the zone"
  value       = aws_route53_zone.this.name_servers
}
