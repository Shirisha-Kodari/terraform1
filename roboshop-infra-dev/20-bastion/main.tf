resource "aws_instance" "bastion" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.bastion_sg_id]
  subnet_id = local.public_subnet_id #

   root_block_device {
      volume_size = 50
      volume_type = "gp3" # or "gp2", depending on your preference
    }
    
  iam_instance_profile = "TerraformAdmin" #atteched to iam role to instance 

  tags = merge(
    local.common_tags,{
        Name = "${var.project}-${var.environment}-bastion"
    }
  )
}


# resource "terraform_data" "bastion" {
#   triggers_replace = [
#     aws_instance.bastion.id
#   ]
  
#   provisioner "file" {
#     source      = "bastion.sh"
#     destination = "/tmp/bastion.sh"
#   }

#   connection {
#     type     = "ssh"
#     user     = "ec2-user"
#     password = "DevOps321"
#     host     = aws_instance.bastion.public_ip
#   }

#   provisioner "remote-exec" {
#     inline = [
#       "chmod +x /tmp/bastion.sh",
#        "sh /tmp/bastion.sh"
#     ]
#   }
# }

# # if issues in private databases server we can troubleshoot by using bastion  