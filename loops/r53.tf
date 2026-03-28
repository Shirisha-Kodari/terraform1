resource "aws_route53_record" "www" {
  count = 4
  zone_id = var.zone_id
  name    = "${var.instances[count.index]}.${var.domain_name}" #mongodb.daws84s.cfd created like this
  type    = "A"
  ttl     = 1
  records = [aws_instance.roboshop[count.index].private_ip] #take ip from output aws_instance.roboshop
  allow_overwrite = true
}