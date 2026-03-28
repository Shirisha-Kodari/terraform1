resource "aws_instance" "expanse" { #this instance created in default security group 
  ami           = "ami-09c813fb71547fc4f"
  instance_type = "t3.micro"
  vpc_security_group_ids = [ aws_security_group.allow_traffic.id ]

  tags = {
    Name = "HelloWorld"
  }
}

resource "aws_security_group" "allow_traffic" {
    name = "allow-traffic"
    description = "sg for allowing traffic" 

 
  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "allow-traffic"
  }
}
               

