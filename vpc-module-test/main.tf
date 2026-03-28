module "vpc" {
    #  source = "../terraform-aws-vpc"
    source = "git::https://github.com/siri-123706/terraform-aws-vpc.git?ref=main"
    #
      /*  project = "roboshop"
       environment = "dev"
       public_subnet_cidrs = ["10.0.1.0/24" , "10.0.2.0/24"] */
    project = "roboshop"
    environment = var.environment
    public_subnet_cidrs = var.public_subnet_cidrs
    private_subnet_cidrs = var.private_subnet_cidrs
    database_subnet_cidrs = var.database_subnet_cidrs

    is_peering_required = true

}

# output "vpc_id" {
# value = module.vpc.vpc_id #-->here value module name module.vpc and output=vpc_id
#}
 # doing like this created vpc id we get vpc id 
 # output store in get like 