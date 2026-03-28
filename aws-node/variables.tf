variable "ami_id" {
    type = string
    default = "ami-09c813fb71547fc4f"
       
}

variable "instance_type" {
    type = string
    default = "t3.micro"
}

variable "tags" {
    type = map (string)
    default = "Hello-world" 

}

variable "sg_tags" {
    type = map(string)
    default = "allow-traffic"
}