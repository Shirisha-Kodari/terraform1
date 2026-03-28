module "backend_alb" {
  source = "terraform-aws-modules/alb/aws"
  version = "9.16.0"
  internal = true
  name    = "${var.project}-${var.environment}-backend-alb" #roboshop-dev-backend-alb
  vpc_id  = local.vpc_id
  subnets = local.private_subnet_ids
  create_security_group = false
  security_groups = [local.backend_alb_sg_id]
  enable_deletion_protection = false
  tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-backend-alb"
    }
  )
}

resource "aws_lb_listener" "backend_alb" {
  load_balancer_arn = module.backend_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      message_body = "<h1>Hello, I am from Backend ALB</h1>"
      status_code  = "200" #success response
    }
  }
}

resource "aws_route53_record" "backend_alb" {
  zone_id = var.zone_id
  name    = "*.backend-dev.${var.zone_name}"
  type    = "A"

  alias {
    name                   = module.backend_alb.dns_name
    zone_id                = module.backend_alb.zone_id # This is the ZONE ID of ALB
    evaluate_target_health = true #If true, Route53 checks the health of the ALB targets.
                    #If the ALB or its targets become unhealthy, Route53 can automatically route traffic to another healthy record (if configured, like in failover or weighted routing).
  }
}






#Create a DNS record that points to my load balancer (ALB), use its DNS name and zone ID, and automatically check its health.”

# module "backend_alb" {
#   source = "terraform-aws-modules/alb/aws"
#   version ="9.16.0"
#   internal = true 

#   name    = "${var.project}-${var.environment}-backend-alb"#roboshop-dev-backend-alb
#   vpc_id  = local.vpc_id
#   subnets = local.private_subnet_ids
#   create_security_group = false
#   security_groups = [local.backend_alb_sg_id]
#   enable_deletion_protection = false

  

#   # # Security Group
#   # security_group_ingress_rules = {
#   #   all_http = {
#   #     from_port   = 80
#   #     to_port     = 80
#   #     ip_protocol = "tcp"
#   #     description = "HTTP web traffic"
#   #     cidr_ipv4   = "0.0.0.0/0"
#   #   }
#   #   all_https = {
#   #     from_port   = 443
#   #     to_port     = 443
#   #     ip_protocol = "tcp"
#   #     description = "HTTPS web traffic"
#   #     cidr_ipv4   = "0.0.0.0/0"
#   #   }
#   # }
#   # security_group_egress_rules = {
#   #   all = {
#   #     ip_protocol = "-1"
#   #     cidr_ipv4   = "10.0.0.0/16"
#   #   }
#   #  }

  
#   tags = merge(
#     local.common_tags,{
#         Name = "${var.project}-${var.environment}-backend-alb"
#     }
#   )
# }



# resource "aws_lb_listener" "backend_alb" {
#   load_balancer_arn = module.backend_alb.arn
#   port              = "80"
#   protocol          = "HTTP"

#   default_action {
#     type = "fixed-response"

#     fixed_response {
#       content_type = "text/html"
#       message_body = "<h1>hello, i am from backend alb</h1>"
#       status_code  = "200"
#     }
#   }
# }




# resource "aws_route53_record" "backend_alb" {
#   zone_id = var.zone_id
#   name    = "*.backend-dev.${var.zone_name}"
#   type    = "A"
#   allow_overwrite = true

#   alias {
#     name                   = module.backend_alb.dns_name
#     zone_id                = module.backend_alb.zone_id # This is the ZONE ID of ALB
#     evaluate_target_health = true
#   }
# }