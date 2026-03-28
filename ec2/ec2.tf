
resource "aws_instance" "roboshop" {
  ami           = "ami-09c813fb71547fc4f"
  instance_type = "t3.micro"
  vpc_security_group_ids = [ aws_security_group.allow_all.id ]
  # vpc_security_group_ids = local.sg_id
  tags = {
    Name = "HelloWorld"
  }
}

resource "aws_security_group" "allow_all" {
    name        = "allow_all_change"
    description = "allow all traffic"
#ingress -->inbound rules
    ingress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1" #-1-->all traffic allow
        cidr_blocks      = ["0.0.0.0/0"] #internet notation 
        ipv6_cidr_blocks = ["::/0"]
    }
    #outbound rules
    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    lifecycle {
      create_before_destroy = true
    }

    tags = {
        Name = "allow-all"
    }
}
