variable "ami_id" {
  description = "AMI ID of joindevops RHEL9"
  type        = string
  default     = "ami-09c813fb71547fc4f"
}

variable "instance_type" {
    default = "t3.micro"
}

variable "ec2_tags"{
    type = map (string)
    default = {
        name = "Roboshop"
        purpose = "variable-demo"
    }
}
variable "sg_name"{
    default = "allow-all"

}
variable "sg_description" {
    default = "allowin all ports from internet" 
}
variable "from_port"{
    default = 0
}
variable "to_port"{
    type = number
    default = 0
}
variable "cidr_blocks"{
    type = list(string)
    default = ["0.0.0.0/0"]

}

variable "sg_tags" {
    default = {
        name = "allow-all"
    }
}
variable "environment"{ 
    default = "dev"
}
variable "instances" {
    default = ["mongodb", "redis", "mysql" ,"rabbitmq"]

} 

variable "zone_id" {
    default = "Z0673912SPW6GV3I8NW2"
}

variable "domain_name" {
     default = "daws84s.cfd"
}