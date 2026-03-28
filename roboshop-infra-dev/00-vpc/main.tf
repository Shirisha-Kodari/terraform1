module "vpc" {
    # source = "../../terraform-aws-vpc"
    source = "git::https://github.com/Shirisha-Kodari/terraform-aws-vpc.git?ref=main"
      
    project = var.project
    environment = var.environment
    public_subnet_cidrs = var.public_subnet_cidrs
    private_subnet_cidrs = var.private_subnet_cidrs
    database_subnet_cidrs = var.database_subnet_cidrs

    is_peering_required = true

}
# output "vpc_ids" {
# value = module.vpc.public_subnet_ids
# }

# output "vpc_id" { this testing purpose 
# value = module.vpc.vpc_id #-->here value module name module.vpc and output=vpc_id
#}
# doing like this created vpc id we get vpc id 
# output store in get like 
# query

#how to get vpc id or subnet ids -->who is developed modules so they should be expose outputs in module
# so that is the way of get output like ids and who are created vpc after created vpc we some vpc 
# vpc id stores in ssm parameter store and how to get vpc id exixting output so we used by 
#data resources 
#so simillary sg ids also stores in ssm parameter and we get output by using data sources 
#