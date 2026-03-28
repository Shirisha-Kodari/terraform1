resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "terraform-vpc"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a" # Specify an AZ
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_instance" "roboshop" {
  ami           = "ami-09c813fb71547fc4f"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.public_subnet_1.id
  tags = {
    Name = "HelloWorld"
  }
}
