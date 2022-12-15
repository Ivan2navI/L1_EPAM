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


output "vpc_public_subnets" {
  description = "IDs of the VPC's public subnets"
  value       = module.vpc.public_subnets
}