# --------------------------------------------------------------------
# --------------------------------------------------------------------
# Tech Environment for Ansible Project
# --------------------------------------------------------------------
# --------------------------------------------------------------------

### otputs.tf

# aws_instance.Data_Base
output "Data_Base_ami" {
  value = aws_instance.Data_Base.ami
}

output "Data_Base_arn" {
  value = aws_instance.Data_Base.arn
}

output "Data_Base_private_ip" {
  value = aws_instance.Data_Base.private_ip
}

output "Data_Base_public_ip" {
  value = aws_instance.Data_Base.public_ip 
}

output "Data_Base_subnet_id" {
  value = aws_instance.Data_Base.subnet_id 
}

output "Data_Base_vpc_security_group_ids" {
  value = aws_instance.Data_Base.vpc_security_group_ids
}

output "Data_Base_tags_all" {
  value = aws_instance.Data_Base.tags_all
}


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






