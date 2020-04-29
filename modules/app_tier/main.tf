# App Tier
# Move here anything to do with the app tier creation

# # create a subnet
# resource "aws_subnet" "app_subnet" {
#   vpc_id = "aws_vpc.app_vpc.id"
#   cidr_block = "10.0.1.0/24"
#     tags = {
#         Name = "ENG54-sara-subnet"
# "172.31.0.0/24"
#   }app_security_group_id
# }


# Creating subnet
resource "aws_subnet" "app_subnet" {
    vpc_id = var.vpc_id
     cidr_block = "10.0.1.0/24"
     availability_zone = "eu-west-1a"
      tags = {
        Name = var.name
          # Name = "ENG54-Sara-app-public-subnet"
      }
    }

    # Creating NACLs
    resource "aws_network_acl" "public-nacl" {
      vpc_id = var.vpc_id

      ingress {
        protocol   = "tcp"
        rule_no    = 100
        action     = "allow"
        cidr_block = "0.0.0.0/0"
        from_port  = 80
        to_port    = 80
      }
      ingress {
        protocol   = "tcp"
        rule_no    = 110
        action     = "allow"
        cidr_block = "0.0.0.0/0"
        from_port  = 443
        to_port    = 443
      }
      ingress {
        protocol   = "tcp"
        rule_no    = 120
        action     = "allow"
        cidr_block = "0.0.0.0/0"
        from_port  = 3000
        to_port    = 3000
      }
      ingress {
        protocol   = "tcp"
        rule_no    = 130
        action     = "allow"
        cidr_block = "0.0.0.0/0"
        from_port  = 1024
        to_port    = 65535
      }
      ingress {
        protocol   = "tcp"
        rule_no    = 140
        action     = "allow"
        cidr_block = "2.25.203.218/32"
        from_port  = 22
        to_port    = 22
      }
      ingress {
       protocol   = "tcp"
       rule_no    = 150
       action     = "allow"
       cidr_block = "10.0.2.0/24"
       from_port  = 27107
       to_port    = 27107
      }

      egress {
        protocol   = "tcp"
        rule_no    = 100
        action     = "allow"
        cidr_block = "0.0.0.0/0"
        from_port  = 0
        to_port    = 0
      }


      tags = {
        Name = "${var.name}-nacl"
      }

    }

# Associate Route_table::
# route table is associate with subnet, exit inside vpc
  resource "aws_route_table" "public"{
    vpc_id = var.vpc_id

    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = var.gateway_id
    #   gateway_id = data.aws_internet_gateway.default-gw.id
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

# Template for initial configuration bash script
  data "template_file" "app_init" {
      template = "${file("./scripts/app/init_scripts.sh.tpl")}"

# .tpl like .erb allow us to interpolate variables into static templates
# Making them dynamic.
vars = {
  my_name = "${var.my_name} is the real name Sara"
  db-ip = var.db_instance_ip

  }
}
# Launching an instance
resource "aws_instance" "app_instance" {
    ami = var.ami
    instance_type = "t2.micro"
    associate_public_ip_address = true
    subnet_id = aws_subnet.app_subnet.id
    vpc_security_group_ids = [aws_security_group.app_security_group.id]


   security_groups = [aws_security_group.app_security_group.id]
   tags = {
     Name = "${var.name}-tf"
   }

  key_name = "Sara-eng54"
  user_data = data.template_file.app_init.rendered
}
# set ports
# For the mongod db, setting private_IP for posts
# AWS give us new IPs -If we want to make one machine aware of another this could be
      #   connection {
      #     type        = "ssh"
      #     host        = self.public_ip
      #     user        = "ubuntu"
      #     private_key = "${file("~/.ssh/Sara-eng54.pem")}"
      #
      #   }
      #
      # provisioner "remote-exec" {
      # inline = [
      #   "cd /home/ubuntu/app",
      #   "sudo chown -R 1000:1000 '/home/ubuntu/.npm'",
      #   "nodejs seeds/seed.js",
      #   "npm start &",
      #     "exit"
      #  ]
      #
      # }
