# AWS EC2 instaces
you can create EC2 instance in joindevops using this module

# Inputs

* ami_id(optional) - AMI ID that need to be used by instance. default is devops-prcatice i,e ami-09c813fb71547fc4f
* instace_type(optional) - instances type to be used by instance. valid values are t3.micro, t3.small, t3.medium. default is t3.micro
* sg_ids(required)- a list of security group IDS to attach instances
* tags(required) - A map of tags to be assoicated with instances

# Outputs
* public_ip - public ip of the instance created
* private_ip - private ip of the instance created
* instance_id - Instance ID of the instance created