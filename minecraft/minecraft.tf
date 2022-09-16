data "aws_ami" "app_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_instance" "minecraft" {
  ami                  = data.aws_ami.app_ami.id
  instance_type        = var.instance_type
  key_name             = "terraform" 
  #I have a key set up called Terraform already, but you can create one and change the key name on the instance
  iam_instance_profile = aws_iam_instance_profile.SSM.id
  
  root_block_device {
    delete_on_termination = var.terminate_volume
  }
  
  tags = {
    "Name"       = "Minecraft Server"
    "Created By" = "Terraform"
    "Managed By" = "Terraform"
  }

  user_data = <<-EOF
      #!/bin/bash
      sudo yum -y update
      sudo yum install -y java-17-amazon-corretto-devel.x86_64
      sudo mkdir /game/minecraft -p
      cd /game/minecraft
      wget -O server.jar ${var.mojang_server}
      echo 'eula=true' | sudo tee eula.txt
      sudo java -Xmx1G - Xms1G -jar server.jar nogui
      EOF
}

output "public_dns" {
  value = aws_instance.minecraft.public_dns
}

output "public_ip" {
  value = aws_instance.minecraft.public_ip
}

#You can now SSM into your instance and run the commands to start the server
#Remember to change directory into /game/minecraft before running the server!