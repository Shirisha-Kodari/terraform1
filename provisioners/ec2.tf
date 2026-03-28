resource "aws_instance" "roboshop" {
  ami           = var.ami_id
  instance_type = var.instance_type 
  vpc_security_group_ids = [ aws_security_group.allow_all.id]

  tags = var.ec2_tags 

  provisioner "local-exec" { # creation time provisioner
    command = " ${self.private_ip} > inventory" # self-->roboshop,ip saved in inevntory 
    on_failure = continue #ignoring the errors again not create 
  }

    provisioner "local-exec" { # this block excute only destroy time 
    when    = destroy # this is destroy time cretion provisioner
    command = "echo 'instance is destroyed'" 
  }

  connection {       #connects to server  
    type     = "ssh"
    user     = "ec2-user" 
    password = "DevOps321" 
    host     = self.public_ip 
  } 

  provisioner "remote-exec" { 
    inline = [
      "sudo dnf install nginx -y",
      "sudo systemctl start nginx", 
    ]
  }
  
provisioner "remote-exec" { #this block excute at  the  destroy time  
  when = destroy
    inline = [
      "sudo systemctl stop nginx"
      

    ]
      
  }
 }

resource "aws_security_group" "allow_all" { 
    name        = var.sg_name
    description = var.sg_description

  ingress {
    from_port        = var.from_port
    to_port          = var.to_port 
    protocol         = "-1"
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

   tags = var.sg_tags  
  }
