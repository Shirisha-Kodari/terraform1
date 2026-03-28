variable "ami_id" {
  type        = string
  default     = "ami-09c813fb71547fc4f"
  description = "AMI ID of joindevops RHEL9"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "ec2_tags" {
    type = map(string)
    default = {
        Name = "Roboshop"
        Purpose = "variables-demo"
    }
}

variable "sg_name" {
    default = "allow-all"
}

variable "sg_description" {
    default = "allowing all ports from internet"
}

variable "from_port" {
    default = 0
}

variable "to_port" {
    type = number
    default = 0
}

variable "cidr_blocks" {
    type = list(string)
    default = ["0.0.0.0/0"]
}

variable "sg_tags" {
    default = { 
        Name = "allow-all"
    }
}

variable "environment" {
    default = "prod"
}

variable "instances" { #map format
    /* default = {
        mongodb = "t3.micro" # each keyword is assigned for every iteration. you will get each.key and each.value
        redis = "t3.micro"
        mysql = "t3.small"
        rabbitmq = "t3.micro"
    } */

     default = {
       nginx-1 = "t3.micro" # each keyword is assigned for every iteration. you will get each.key and each.value
        nginx-2 = "t2.micro"
    }
    # default = ["mongodb", "redis", "mysql", "rabbitmq"]
    #  default = ["nginx-1, nginx-2"]
}

variable "zone_id" {
    default = "Z032558618100M4EJX8X4"
}

variable "domain_name" {
    default = "daws84s.cfd"
}
