locals {
  final_name = "${var.project}-${var.environment}-${var.component}" #roboshop-dev-cart
  ec2_tags = merge(
    var.common_tags,
    {
        environment = "dev",
        version = "1.0"
    }
  )
}