# set provider and configure AWS provider.

provider "aws" {
  region = "eu-west-1"
}

# Create a VPC ( app_vpc is the name of vpc that we gave)
resource "aws_vpc" "app_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "ENG-54-${var.name}-vpc"
  }
}

# use our DevOps Vpc
    #vpc-07e47e9d90d2076da

### Creating APP Tier

# Internet Gateway
# we don't need a new Internet Gateway (IG)
# we can query our exit vpc/infrastructure with the 'data' handler/function
# Data allow us to get things in our terraform


# we won't use this anymore because we used DevOPs VPC before
# data "aws_internet_gateway" "default-gw"{
#   filter {
#     name = "attachment.vpc-id" # on the hashicorp docs, it referenc AWS-API thats has this filer " attachement"
#     values = [var.vpc_id]
#   }
# }

#Create Internet Gateway
resource "aws_internet_gateway" "gateway_id" {
  vpc_id = aws_vpc.app_vpc.id
  tags = {
    Name = "${var.name}-ig"
  }
}


# Call module to creat app_tier with all the variables wev passed to it

module "app" {
  source = "./modules/app_tier/"
  vpc_id = aws_vpc.app_vpc.id
  name   = var.name
  ami    = var.ami
  gateway_id = aws_internet_gateway.gateway_id.id
  # gateway_id = data.aws_internet_gateway.default-gw.id
}


module "db" {
  source = "./modules/db_tier/"
  vpc_id = aws_vpc.app_vpc.id
  name   = var.name
  ami    = var.ami
  gateway_id = aws_internet_gateway.gateway_id.id
  # gateway_id = data.aws_internet_gateway.default-gw.id
}
# Notes:::
    # Inbound and outbound  rules for public subnet

    ### Creating DB
    # create private subnet
    # # Inbound and outbound  rules for private subnet
    # Deploying Instance with AMI that has mongodb inside
    # SG rules for private instance
    # Initi script for private instance

    ###
    # Cretae Instance with Bastion server
    # SG for bastion server  >> SG --> SecurityGroup
    # init scriptt for bastion server
