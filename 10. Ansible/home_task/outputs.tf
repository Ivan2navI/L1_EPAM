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
  value = aws_instance.Server.private_ip
}

output "Server_public_ip" {
  value = aws_instance.Server.public_ip 
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
  value = aws_instance.Node1.private_ip
}

output "Node1_public_ip" {
  value = aws_instance.Node1.public_ip 
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
  value = aws_instance.Node2.private_ip
}

output "Node2_public_ip" {
  value = aws_instance.Node2.public_ip 
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






