## Key pair (login)
resource "aws_key_pair" "my_key" {
  key_name   = "terra-key-ec2"
  public_key = file("terra-key-ec2.pub")
  
}

## VPC(virtual private cloud)

resource "aws_default_vpc" "default" {
  
}
## security group (networking)

resource "aws_security_group" "my_security_group" {
  name        = "automate-sg"
  description = "Allow TF to generate security group"
  vpc_id      = aws_default_vpc.default.id

  ## inbound rule to allow SSH access or HttP

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"

  }
  ## outbound rule to allow all traffic
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "automate-sg"
  }
  
}

## EC2 instance (compute)
resource "aws_instance" "my_instance" {
  for_each = tomap({
    my-first-terraform-instance = "t2.micro"
  })

  key_name = aws_key_pair.my_key.key_name 
  security_groups = [aws_security_group.my_security_group.name]
  instance_type = "t3.micro" ## we can also write this if we have variable file each.key if we need a group of instances with different instance types
  ami = "ami-0b6d9d3d33ba97d99" # Ubuntu Server instance

  user_data = file("install.nginx.sh")   ## this is optional to use and run the script 

  root_block_device {
    volume_size = 15      ## we can also write this if we have variable file -->var.env == "prd" ? 40 : var.ec2_default_root_storage_size
    volume_type = "gp3"
  }
  tags = {
    Name = "my-first-terraform-instance"  
    Environment = "dev"
    }
}

