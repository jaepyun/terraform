
resource "aws_security_group" "minecraft" {
  name        = "Minecraft"
  description = "Enables minecraft ports"
  vpc_id      = "vpc-0aa9f50db142b48ea"

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.my_ip}/32"]
  }

  ingress {
    description = "minecraft"
    from_port   = 25565
    to_port     = 25565
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_vpc_endpoint_security_group_association" "sg_ec2" {
  vpc_endpoint_id   = aws_instance.minecraft.id
  security_group_id = aws_security_group.minecraft.id
}