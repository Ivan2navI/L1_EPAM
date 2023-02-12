# --------------------------------------------------------------------
# --------------------------------------------------------------------
# Tech Environment for Ansible Project
# --------------------------------------------------------------------
# --------------------------------------------------------------------

### otputs.tf
# aws_instance.Server
output "Server_ami" {
  value = aws_instance.Server.ami
}

output "Server_arn" {
  value = aws_instance.Server.arn
}

output "Server_private_ip" {
  value = aws_instance.Server.private_dns
}

output "Server_public_ip" {
  value = aws_instance.Server.public_dns
}

output "Server_subnet_id" {
  value = aws_instance.Server.subnet_id 
}

output "Server_vpc_security_group_ids" {
  value = aws_instance.Server.vpc_security_group_ids
}

output "Server_tags_all" {
  value = aws_instance.Server.tags_all
}

# --------------------------------------------------------------------
# aws_instance.Node1
output "Node1_ami" {
  value = aws_instance.Node1.ami
}

output "Node1_arn" {
  value = aws_instance.Node1.arn
}

output "Node1_private_ip" {
  value = aws_instance.Node1.private_dns
}

output "Node1_public_ip" {
  value = aws_instance.Node1.public_dns
}

output "Node1_subnet_id" {
  value = aws_instance.Node1.subnet_id 
}

output "Node1_vpc_security_group_ids" {
  value = aws_instance.Node1.vpc_security_group_ids
}

output "Node1_tags_all" {
  value = aws_instance.Node1.tags_all
}

# --------------------------------------------------------------------
# aws_instance.Node2
output "Node2_ami" {
  value = aws_instance.Node2.ami
}

output "Node2_arn" {
  value = aws_instance.Node2.arn
}

output "Node2_private_ip" {
  value = aws_instance.Node2.private_dns
}

output "Node2_public_ip" {
  value = aws_instance.Node2.public_dns 
}

output "Node2_subnet_id" {
  value = aws_instance.Node2.subnet_id 
}

output "Node2_vpc_security_group_ids" {
  value = aws_instance.Node2.vpc_security_group_ids
}

output "Node2_tags_all" {
  value = aws_instance.Node2.tags_all
}

# --------------------------------------------------------------------
# aws_instance.Node3
output "Node3_ami" {
  value = aws_instance.Node3.ami
}

output "Node3_arn" {
  value = aws_instance.Node3.arn
}

output "Node3_private_ip" {
  value = aws_instance.Node3.private_dns
}

output "Node3_public_ip" {
  value = aws_instance.Node3.public_dns
}

output "Node3_subnet_id" {
  value = aws_instance.Node3.subnet_id 
}

output "Node3_vpc_security_group_ids" {
  value = aws_instance.Node3.vpc_security_group_ids
}

output "Node3_tags_all" {
  value = aws_instance.Node3.tags_all
}

# --------------------------------------------------------------------
# aws_instance.Node4
output "Node4_ami" {
  value = aws_instance.Node4.ami
}

output "Node4_arn" {
  value = aws_instance.Node4.arn
}

output "Node4_private_ip" {
  value = aws_instance.Node4.private_dns
}

output "Node4_public_ip" {
  value = aws_instance.Node4.public_dns 
}

output "Node4_subnet_id" {
  value = aws_instance.Node4.subnet_id 
}

output "Node4_vpc_security_group_ids" {
  value = aws_instance.Node4.vpc_security_group_ids
}

output "Node4_tags_all" {
  value = aws_instance.Node4.tags_all
}

# --------------------------------------------------------------------
# aws_internet_gateway.IGW:
output "AWS_Internet_Gateway" {
  value = aws_internet_gateway.IGW.id
}

output "AWS_Internet_Gateway_vpc_id" {
  value = aws_internet_gateway.IGW.vpc_id
}

output "AWS_Internet_Gateway_tags_all" {
  value = aws_internet_gateway.IGW.tags_all
}

# --------------------------------------------------------------------
# aws_security_group.Security_Group:
output "Security_Group_arn" {
  value = aws_security_group.Security_Group.arn
}
output "Security_Group_id" {
  value = aws_security_group.Security_Group.id
}

output "Security_Group_vpc_id" {
  value = aws_security_group.Security_Group.vpc_id
}






