output "vpc_id" {
  description = "ID of the created VPC."
  value       = aws_vpc.this.id
}

output "vpc_cidr_block" {
  description = "IPv4 CIDR range assigned to the VPC."
  value       = aws_vpc.this.cidr_block
}

output "public_subnet_ids" {
  description = "IDs of the public subnets."
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "IDs of the private subnets."
  value       = aws_subnet.private[*].id
}

output "availability_zones" {
  description = "Availability Zones used by the subnets."
  value       = local.azs
}

output "nat_gateway_id" {
  description = "NAT Gateway ID, or null when NAT is disabled."
  value       = var.enable_nat_gateway ? aws_nat_gateway.this[0].id : null
}

output "flow_log_group_name" {
  description = "CloudWatch Log Group receiving VPC Flow Logs."
  value       = aws_cloudwatch_log_group.flow_logs.name
}
