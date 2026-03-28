resource "aws_instance" "roboshop" {
  ami           = var.ami_id #left side and right side names no need to be same 
  instance_type = var.instance_type
  vpc_security_group_ids = [ aws_security_group.allow_all.id ] #we created own security group 

  tags = var.ec2_tags
}


resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all inbound traffic and all outbound traffic"
  
  ingress {
    from_port        = var.ami_id
    to_port          = var.to_port
    protocol         = "-1" # -1 allow all inbound  tarffic 
    cidr_blocks      = var.cidr_blocks 
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = var.from_port
    to_port          = var.to_port 
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }


  tags = {
     Name = "allow_all"
  }
}

