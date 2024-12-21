provider "aws" {
  region = "var.aws_region" # Change to your preferred region
}

# Version variable
variable "version" {
  description = "The version of the infrastructure"
  default     = "v1.0.0"
}

# AWS Key Pair
resource "aws_key_pair" "key" {
  key_name   = "key"
  public_key = file("secret.KEY")
}

# Security Group
resource "aws_security_group" "ec2_sg" {
  name        = "ec2-security-group"
  description = "Allow SSH traffic"
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "EC2SecurityGroup"
  }
}

# EC2 Instance
resource "aws_instance" "ec2" {
  ami           = "var.aws_ami" 
  instance_type = "var.instance_type"
  key_name      = aws_key_pair.key.key_name
  security_groups = [aws_security_group.ec2_sg.name]

  tags = {
    Name    = "MyEC2Instance"
    Version = var.version
  }
}

# Output the version
output "deployed_version" {
  description = "The deployed version of the EC2 instance"
  value       = var.version
}

# Output the instance public IP
output "instance_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.ec2.public_ip
}
