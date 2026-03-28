resource "aws_key_pair" "openvpn" {
  key_name   = "kodar"
  public_key = file("d:\\devops84s\\kodar.pub") #for mac use / , copy your path where your key kodar.pub
}


resource "aws_instance" "openvpn" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.vpn_sg_id]
  subnet_id = local.public_subnet_id
  key_name = aws_key_pair.openvpn.key_name
  user_data = file("openvpn.sh") 

  tags = merge(
    local.common_tags,{
        Name = "${var.project}-${var.environment}-openvpn"
    }
  )
}


resource "aws_route53_record" "openvpn" {
  zone_id = var.zone_id
  name    = "openvpn-${var.environment}.${var.zone_name}"
  type    = "A"
  ttl     = 1
  records = [aws_instance.openvpn.public_ip]
  allow_overwrite = true 
}