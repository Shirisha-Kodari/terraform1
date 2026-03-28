# VPC Module
this module is developed by for joindevops company project inside joindevops follow this module to create their VPC

## Inputs 
* project (requires) - user should specify their project name
* environment(required) - users should specify their environment
* cidr_block(optional) - users can provide their CIDR block. default is 10.0.0.0/16

## Outputs
* vpc_id - Exports VPC ID created 