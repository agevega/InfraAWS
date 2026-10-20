output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.this.id
}

output "vpc_cidr" {
  description = "CIDR block of the VPC"
  value       = aws_vpc.this.cidr_block
}

output "igw_id" {
  description = "ID of the Internet Gateway"
  value       = aws_internet_gateway.this.id
}

output "public_subnet_a_id" {
  description = "ID of the public subnet in AZ a"
  value       = aws_subnet.public["a"].id
}

output "public_subnet_b_id" {
  description = "ID of the public subnet in AZ b"
  value       = aws_subnet.public["b"].id
}

output "public_subnet_c_id" {
  description = "ID of the public subnet in AZ c"
  value       = aws_subnet.public["c"].id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets, by AZ letter"
  value       = { for az, subnet in aws_subnet.public : az => subnet.id }
}

output "private_subnet_a_id" {
  description = "ID of the private subnet in AZ a"
  value       = aws_subnet.private["a"].id
}

output "private_subnet_b_id" {
  description = "ID of the private subnet in AZ b"
  value       = aws_subnet.private["b"].id
}

output "private_subnet_c_id" {
  description = "ID of the private subnet in AZ c"
  value       = aws_subnet.private["c"].id
}

output "private_subnet_ids" {
  description = "IDs of the private subnets, by AZ letter"
  value       = { for az, subnet in aws_subnet.private : az => subnet.id }
}

output "db_subnet_a_id" {
  description = "ID of the database subnet in AZ a"
  value       = aws_subnet.db["a"].id
}

output "db_subnet_b_id" {
  description = "ID of the database subnet in AZ b"
  value       = aws_subnet.db["b"].id
}

output "db_subnet_c_id" {
  description = "ID of the database subnet in AZ c"
  value       = aws_subnet.db["c"].id
}

output "db_subnet_ids" {
  description = "IDs of the database subnets, by AZ letter"
  value       = { for az, subnet in aws_subnet.db : az => subnet.id }
}

output "public_route_table_id" {
  description = "ID of the public route table"
  value       = aws_route_table.public.id
}

output "private_route_table_a_id" {
  description = "ID of the private route table in AZ a"
  value       = aws_route_table.private["a"].id
}

output "private_route_table_b_id" {
  description = "ID of the private route table in AZ b"
  value       = aws_route_table.private["b"].id
}

output "private_route_table_c_id" {
  description = "ID of the private route table in AZ c"
  value       = aws_route_table.private["c"].id
}

output "private_route_table_ids" {
  description = "IDs of the private route tables, by AZ letter"
  value       = { for az, rtb in aws_route_table.private : az => rtb.id }
}

output "db_route_table_a_id" {
  description = "ID of the database route table in AZ a"
  value       = aws_route_table.db["a"].id
}

output "db_route_table_b_id" {
  description = "ID of the database route table in AZ b"
  value       = aws_route_table.db["b"].id
}

output "db_route_table_c_id" {
  description = "ID of the database route table in AZ c"
  value       = aws_route_table.db["c"].id
}

output "db_route_table_ids" {
  description = "IDs of the database route tables, by AZ letter"
  value       = { for az, rtb in aws_route_table.db : az => rtb.id }
}
