# set provider and configure AWS provider.

provider "aws" {
  region = "eu-west-1"
}

# Create a VPC ( app_vpc is the name of vpc that we gave)
# resource "aws_vpc" "app_vpc" {
#   cidr_block = "10.0.0.0/16"
#   tags = {
#     Name = "ENG-54-app_vpc"
#   }
# }


# # create a subnet
# resource "aws_subnet" "app_subnet" {
#   vpc_id = "aws_vpc.app_vpc.id"
#   cidr_block = "10.0.1.0/24"
#     tags = {
#         Name = "ENG54-sara-subnet"
# "172.31.0.0/24"
#   }
# }

# use our DevOps Vpc
    #vpc-07e47e9d90d2076da
# create  new subnet
# Move our instance into said subnet
resource "aws_subnet" "app_subnet" {
    vpc_id = "vpc-07e47e9d90d2076da"
     cidr_block = "172.31.32.0/24"
     availability_zone = "eu-west-1a"
      tags = {
          Name = "ENG54-Sara-app-public-subnet"
      }
}


# Launching an instance
resource "aws_instance" "app_instance" {
    ami = "ami-0c5dd00b3803df8a5"
    instance_type = "t2.micro"
    associate_public_ip_address = true
    subnet_id = aws_subnet.app_subnet.id
    vpc_security_group_ids = [aws_security_group.app_security_group.id]
      tags = {
          Name = "ENG54-Sara-app"
      }
}

resource "aws_security_group" "app_security_group"{
  name        = "sara-app_security_group"
  description = "Allow 80 inbound traffic"
  vpc_id      = "vpc-07e47e9d90d2076da"

  ingress {
    description = "security-group"
    from_port   = 80
    to_port     = 80
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
    Name = "ENG54-sara-app_security_group"
  }
}
