variable "security_group_ids" {
    default = ["sg-03f077f464f434b47"]

}
variable "tags" {
    default = {
    Name = "roboshop-cart"
    Terraform = "true"
    Environment = "dev"

}
}
variable "instance_type" {
    default = "t3.small"
}

#variable "instance_type" {
   # default = "x3.large" # 
#}