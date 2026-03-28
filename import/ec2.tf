resource "aws_instance" "linux" {
  ami = "ami-09c813fb71547fc4f"
  instance_type = "t3.micro"
  vpc_security_group_ids = ["sg-03f077f464f434b47"]

  tags = {
    Name = "linux-server"
 }
}