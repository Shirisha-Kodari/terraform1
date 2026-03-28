resource "aws_lb_target_group" "catalogue" { # created catalogue target group
  name     = "${var.project}-${var.environment}-catalogue" #roboshop-dev-catalogue
  port     = 8080
  protocol = "HTTP" #http subset of tcp 
  vpc_id   = local.vpc_id 
  deregistration_delay = 120 #before deleted instances catalogue take time 120 

  health_check {
    healthy_threshold = 2 #2 healthy checks 
    interval = 5 #every 5mints healthy cheacks
    matcher = "200-299" #success 
    path = "/health" 
    port = 8080 
    timeout = 2 #response with 2 sec healthy or unhealthy 
    unhealthy_threshold = 3 #unhealthy 3 
  }
}

resource "aws_instance" "catalogue" { #confugure catalogue instance 
  ami           = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.catalogue_sg_id]
  subnet_id = local.private_subnet_id
  tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-catalogue "
    }
  )
}


resource "terraform_data" "catalogue" {
  triggers_replace = [
    aws_instance.catalogue.id
  ]
  
  provisioner "file" { #copy the file into instance 
    source      = "catalogue.sh"
    destination = "/tmp/catalogue.sh"
  }

  connection { #connected instance and start the server
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.catalogue.private_ip
  }

  provisioner "remote-exec" { #here run the server take excution permission and run the server with sudo
    inline = [
      "chmod +x /tmp/catalogue.sh",
      "sudo sh /tmp/catalogue.sh catalogue ${var.environment}"
    ]
  }
}


resource "aws_ec2_instance_state" "catalogue" { # here stopped instance after completed configuration 
  instance_id = aws_instance.catalogue.id
  state       = "stopped"
  depends_on = [ terraform_data.catalogue ] # catalogue configuration completed as soon as start this catalogue ,depens on =resource depends on another resurce
}

resource "aws_ami_from_instance" "catalogue" { # take ami from instance create instance 
  name               = "${var.project}-${var.environment}-catalogue"
  source_instance_id = aws_instance.catalogue.id
  depends_on = [aws_ec2_instance_state.catalogue]
  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-catalogue"
    }
  )
}

resource "terraform_data" "catalogue_delete" { #deleted the old instance 
  triggers_replace = [
    aws_instance.catalogue.id
  ]
  

  provisioner "local-exec" {
    command = "aws ec2 terminate-instances --instance-ids ${aws_instance.catalogue.id}"
              # aws ec2 terminate-instances --instance-ids <i-xxxxxxxx>
  
   }
  depends_on = [ aws_ami_from_instance.catalogue ]
}


resource "aws_launch_template" "catalogue" {
  name = "${var.project}-${var.environment}-catalogue"

  image_id = aws_ami_from_instance.catalogue.id
  instance_initiated_shutdown_behavior = "terminate" #when the traffic is decreased ASG terminate instance
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.catalogue_sg_id]
  update_default_version = true # each time you update, new version will become default
  tag_specifications {
    resource_type = "instance"
    # EC2 tags created by ASG
    tags = merge(
      local.common_tags,
      {
        Name = "${var.project}-${var.environment}-catalogue"
      }
    )
  }

  # volume tags created by ASG
  tag_specifications {
    resource_type = "volume"

    tags = merge(
      local.common_tags,
      {
        Name = "${var.project}-${var.environment}-catalogue"
      }
    )
  }

  # launch template tags
  tags = merge(
      local.common_tags,
      {
        Name = "${var.project}-${var.environment}-catalogue"
      }
  )

}

resource "aws_autoscaling_group" "catalogue" {
  name                 = "${var.project}-${var.environment}-catalogue"
  desired_capacity   = 1
  max_size           = 10 #when traffic high increase 10 instances created
  min_size           = 1
  target_group_arns = [aws_lb_target_group.catalogue.arn]
  vpc_zone_identifier  = local.private_subnet_ids
  health_check_grace_period = 90 #afrer completed instances then healthy checks started 
  health_check_type         = "ELB"
 
  launch_template {
    id      = aws_launch_template.catalogue.id
    version = aws_launch_template.catalogue.latest_version
  }

   dynamic "tag" {
    for_each = merge(
      local.common_tags,{
        Name = "${var.project}-${var.environment}-catalogue"

      }
    )
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
   }
     instance_refresh { #after lunch template chnages, refresh the instances  
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = ["launch_template"]
  }

  timeouts {
    
    delete = "15m" # deteleted instances with in 15 mints 
    
  }
    
   }


resource "aws_autoscaling_policy" "catalogue" {
  name                   = "${var.project}-${var.environment}-catalogue"
  autoscaling_group_name = aws_autoscaling_group.catalogue.name
  policy_type            = "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 75.0 #each instance target 75 then create new instace
  }
}


resource "aws_lb_listener_rule" "catalogue" {
  listener_arn = local.backend_alb_listener_arn
  priority     = 10

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.catalogue.arn
  }

  condition {
    host_header { #rule -->catlogue.backend-dev.daws84s.cfd 
      values = ["catalogue.backend-${var.environment}.${var.zone_name}"]
    }
  }
}
#scale out -->create or expand 
#scale in -->remove or delete 