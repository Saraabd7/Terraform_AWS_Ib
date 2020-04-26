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
    vpc_id = var.vpc_id
     cidr_block = "172.31.32.0/24"
     availability_zone = "eu-west-1a"
      tags = {
        Name = var.name
          # Name = "ENG54-Sara-app-public-subnet"
      }
}
# Internet Gateway
# we don't need a new Internet Gateway (IG)
# we can query our exit vpc/infrastructure with the 'data' handler/function


# Associate Route_table::
# route table is associate with subnet, exit inside vpc
  resource "aws_route_table" "public"{
    vpc_id = var.vpc_id

    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = data.aws_internet_gateway.default-gw.id
    }
    tags = {
      Name = "${var.name}-route"
    }
  }

  resource "aws_route_table_association" "assoc" {
  subnet_id = aws_subnet.app_subnet.id
  route_table_id = aws_route_table.public.id
}

resource "aws_security_group" "app_security_group" {
  name        = "sara-app_security_group"
  description = "Allow 80 inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allows port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allows port 3000"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allows port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
  from_port = 27017
  to_port =  27017
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-tags"
  }
}


data "aws_internet_gateway" "default-gw"{
  filter {
    name = "attachment.vpc-id" # on the hashicorp docs, it referenc AWS-API thats has this filer " attachement"
    values = [var.vpc_id]
  }
}


# Launching an instance
resource "aws_instance" "app_instance" {
    ami = var.ami
    instance_type = "t2.micro"
    associate_public_ip_address = true
    subnet_id = aws_subnet.app_subnet.id
    vpc_security_group_ids = [aws_security_group.app_security_group.id]
      key_name = "Sara-eng54"
    # user_data = data.template_file.app_init.rendered
    tags = {
      Name = "${var.name}-nodejs-tf"
    }

    provisioner "remote-exec" {
    inline = [
      "cd /home/ubuntu/app",
      "sudo chown -R 1000:1000 '/home/ubuntu/.npm'",
      "nodejs seeds/seed.js",
      "npm start"
    ]
  }
      connection {
        type        = "ssh"
        host        = self.public_ip
        user        = "ubuntu"
        private_key = "${file("~/.ssh/Sara-eng54.pem")}"
      }


  # data "template_file" "app_init" {
  #   template = "${file("./scripts/init_scripts.sh.tpl")}"
  #   }

   }
