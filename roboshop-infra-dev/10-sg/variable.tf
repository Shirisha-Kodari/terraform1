variable "project" {
    default = "roboshop"
}

variable "environment" {
    default = "dev"
}

variable "frontend_sg_name" {
    default = "frontend"

}

variable "frontend_sg_description" {
    default = "created sg for frontend instace"
}

variable "bastion_sg_name" {
    default = "bastion"
}

variable "bastion_sg_description" {
    default = "created sg for bastion instance"
}

variable "mongodb_ports_vpn"{  # allow traffic fromm ssh port 22 to mongodb database port 27017,
    default = [22, 27017]
}


variable "redis_ports_vpn" {
    default = [22, 6379]
}

variable "mysql_ports_vpn" {
    default = [22, 3306]
}

variable "rabbitmq_ports_vpn" { #vpn allow traffic from ssh port 22 to redis 
    default = [22, 5672]
}

#if you mentioned tags in module so no need to again mentioned real infra