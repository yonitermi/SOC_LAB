provider "aws" {
  region = var.aws_region
}

resource "aws_eip" "soc_lab_eip" {
  vpc = true
}

resource "aws_security_group" "soc_lab_sg" {
  name        = "soc_lab_sg"
  description = "SOC Lab Security Group"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Splunk web
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "soc_lab" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.soc_lab_sg.id]
  user_data              = file("${path.module}/user_data.sh")

  tags = {
    Name = "SOC_LAB"
  }
}

resource "aws_eip_association" "soc_lab_eip_assoc" {
  instance_id   = aws_instance.soc_lab.id
  allocation_id = aws_eip.soc_lab_eip.id
}
