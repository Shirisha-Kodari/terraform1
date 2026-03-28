variable "ami_id" {
    type = string
    default = "ami-09c813fb71547fc4f"
    description = " AMI ID of the EC2 instances"
}

variable "instance_type" {
    default = "t3.micro"
    type = string
    description = "instance size"

    validation {
        condition     = contains(["t3.micro", "t3.small", "t3.medium"], var.instance_type) 
        error_message = "Valid values for instance_type are: t3.micro, t3.small, t3.medium" # this are reqired
    } 

}

variable  "sg_ids" {
    type = list
}

variable "tags" {
    type = map

}