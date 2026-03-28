resource "aws_instance" "sonarqube" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.sonarqube_sg_id]
  subnet_id = local.public_subnet_id

   tags = {
    Name = "sonarqube"
  }
 
  root_block_device{
    volume_size = 50
    volume_type = "gp3" # or "gp2", depending on your preference
  }
  
  user_data = file("sonar.sh")
}


    
 
