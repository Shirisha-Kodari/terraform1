data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project}/${var.environment}/vpc_id"
}

# ssm parametere refers from data soucres 
# vpc id stores in ssm parameter responsible for who are created vpc and output means vpc id keeps in ssm parametr