 resource "aws_vpc" "main" {
      cidr_block       = "10.0.0.0/16"
      instance_tenancy = "default"
      enable_dns_support = true
      enable_dns_hostnames = true
      tags = {
        Name = "expanse-vpc"
      }
    }

     resource "aws_subnet" "public" {
      vpc_id            = aws_vpc.main.id 
      cidr_block        = "10.0.1.0/24"
      availability_zone = "us-east-1a"
      map_public_ip_on_launch = true # For public subnets
      tags = {
        Name = "main-public-subnet"
      }
    }

    resource "aws_subnet" "private" {
      vpc_id            = aws_vpc.main.id
      cidr_block        = "10.0.10.0/24"
      availability_zone = "us-east-1a"
      tags = {
        Name = "expanse-private-subnet"
      }
    }

    # resource "aws_internet_gateway" "igw" {
    #   vpc_id = aws_vpc.main.id
    #   tags = {
    #     Name = "main-igw"
    #   }
    # }

    # resource "aws_route_table" "public" {
    #   vpc_id = aws_vpc.main.id
    #   route {
    #     cidr_block = "0.0.0.0/0"
    #     gateway_id = aws_internet_gateway.igw.id
    #   }
    #   tags = {
    #     Name = "my-public-route-table"
    #   }
    # }

    # resource "aws_route_table_association" "public" {
    #   subnet_id      = aws_subnet.public.id
    #   route_table_id = aws_route_table.public.id
    # }
    #   resource "aws_eip" "nat" {
    #   domain = "vpc"
    # }

    # resource "aws_nat_gateway" "nat" {
    #   allocation_id = aws_eip.nat.id
    #   subnet_id     = aws_subnet.public.id # NAT Gateway resides in a public subnet
    #   tags = {
    #     Name = "main-nat-gateway"
    #   }
    # }

    # resource "aws_route_table" "private" {
    #   vpc_id = aws_vpc.main.id
    #   route {
    #     cidr_block = "0.0.0.0/0"
    #     nat_gateway_id = aws_nat_gateway.nat.id
    #   }
    #   tags = {
    #     Name = "main-private-route-table"
    #   }
    # }

    # resource "aws_route_table_association" "private" {
    #   subnet_id      = aws_subnet.private.id
    #   route_table_id = aws_route_table.private.id
    # }