# Output variable definitions


output "ec2_instance_id" {
  description = "List of IDs of instances"
  value       = module.ec2_instances.id
}

output "ec2_instance_arn" {
  description = "List of ARNs of instances"
  value       = module.ec2_instances.arn
}

output "ec2_instance_public_ip" {
  description = "List of public IP addresses assigned to the instances."
  value       = module.ec2_instances.public_ip
}

output "ec2_instance_public_dns" {
  description = "List of public DNS names assigned to the instances."
  value       = module.ec2_instances.public_dns
}

output "ec2_instance_private_dns" {
  description = "private dns of EC2 instances"
  value       = module.ec2_instances.private_dns
}



output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}

output "vpc_main_route_table_id" {
  description = "The ID of the main route table associated with this VPC"
  value       = module.vpc.vpc_main_route_table_id
}

output "private_subnets_cidr_blocks" {
  description = "List of cidr_blocks of private subnets"
  value       = module.vpc.private_subnets_cidr_blocks
}

output "public_subnets_cidr_blocks" {
  description = "List of cidr_blocks of public subnets"
  value       = module.vpc.public_subnets_cidr_blocks
}

output "vpc_public_subnets" {
  description = "IDs of the VPC's public subnets"
  value       = module.vpc.public_subnets
}

