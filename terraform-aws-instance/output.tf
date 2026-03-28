
output "public_ip" {
  value       = aws_instance.this.public_ip
}

output "private_ip" {
  value       = aws_instance.this.private_ip
}

output "instance_id" {
  value       = aws_instance.this.id
}

# output "private_ip" {
# value = aws_instance.this.id # here which name mentioned in ec2.tf that name mentioned out put 
#}