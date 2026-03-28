variable "project"{
    default = "roboshop"
    
}

variable "environment" {
    default = "dev"
}

variable "component" {
    default = "cart"
}

variable "common_tags"{
    default = {
        Project = "roboshop"
        Terraform = "true"
    }
}
# variable "final-name" {
#     default = "${var.project}-${var.environment}-${var.component}"
# }