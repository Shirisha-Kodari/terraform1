resource "aws_instance" "mongodb" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.mongodb_sg_id]
  subnet_id = local.database_subnet_id

  tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-mongodb"
    }
  )
}

# for arbitrary actions taken by a provisioner.
resource "terraform_data" "mongodb" {
  triggers_replace = [ # when created instance and completed after triggered 
    aws_instance.mongodb.id #when id of instance changed means change id terraform_data mongodb recreate new id menas destory and recerate ec2
  ]

  provisioner "file" { #copy the file into instance
    source      = "boostrap.sh"
    destination = "/tmp/boostrap.sh"
  }

  connection {  #connected to instance mongodb
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.mongodb.private_ip
  }

provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/boostrap.sh", #give excute permission 
      "sudo sh /tmp/boostrap.sh mongodb ${var.environment}" #run server 
    ]
  }
}


resource "aws_instance" "redis" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.redis_sg_id]
  subnet_id = local.database_subnet_id

  tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-redis"
    }
  )
}

resource "terraform_data" "redis" {
  triggers_replace = [
    aws_instance.redis.id
  ]
  
  provisioner "file" {
    source      = "boostrap.sh" #setup configuration boostrap-->configuration
    destination = "/tmp/boostrap.sh"
  }

  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.redis.private_ip
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/boostrap.sh",
      "sudo sh /tmp/boostrap.sh redis ${var.environment}"
    ]
  }
}

resource "aws_instance" "mysql" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.mysql_sg_id]
  subnet_id = local.database_subnet_id
   iam_instance_profile = "EC2RoleToFetchSSMParams"
  tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-mysql"
    }
  )
}

resource "terraform_data" "mysql" {
  triggers_replace = [
    aws_instance.mysql.id
  ]
  
  provisioner "file" {
    source      = "boostrap.sh"
    destination = "/tmp/boostrap.sh"
  }

  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.mysql.private_ip
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/boostrap.sh",
      "sudo sh /tmp/boostrap.sh mysql ${var.environment}"
    ]
  }
}

resource "aws_instance" "rabbitmq" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.rabbitmq_sg_id]
  subnet_id = local.database_subnet_id

  tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-rabbitmq"
    }
  )
}

resource "terraform_data" "rabbitmq" {
  triggers_replace = [
    aws_instance.rabbitmq.id
  ]
  
  provisioner "file" {
    source      = "boostrap.sh"
    destination = "/tmp/boostrap.sh"
  }
  
  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.rabbitmq.private_ip
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/boostrap.sh",
      "sudo sh /tmp/boostrap.sh rabbitmq ${var.environment}"
    ]
  }
}

resource "aws_route53_record" "mongodb" {
  zone_id = var.zone_id
  name    = "mongodb-${var.environment}.${var.zone_name}" #mongodb-dev.daws84s.cfd
  type    = "A"
  ttl     = 1
  records = [aws_instance.mongodb.private_ip]
  allow_overwrite = true
}


resource "aws_route53_record" "redis" {
  zone_id = var.zone_id
  name    = "redis-${var.environment}.${var.zone_name}"
  type    = "A"
  ttl     = 1
  records = [aws_instance.redis.private_ip]
  allow_overwrite = true
}


resource "aws_route53_record" "mysql" {
  zone_id = var.zone_id
  name    = "mysql-${var.environment}.${var.zone_name}"
  type    = "A"
  ttl     = 1
  records = [aws_instance.mysql.private_ip]
  allow_overwrite = true
}


resource "aws_route53_record" "rabbitmq" {
  zone_id = var.zone_id
  name    = "rabbitmq-${var.environment}.${var.zone_name}"
  type    = "A"
  ttl     = 1
  records = [aws_instance.rabbitmq.private_ip]
  allow_overwrite = true
}

