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




# use our DevOps Vpc
    #vpc-07e47e9d90d2076da

### Creating APP Tier

# Internet Gateway
# we don't need a new Internet Gateway (IG)
# we can query our exit vpc/infrastructure with the 'data' handler/function
# Data allow us to get things in our terraform
data "aws_internet_gateway" "default-gw"{
  filter {
    name = "attachment.vpc-id" # on the hashicorp docs, it referenc AWS-API thats has this filer " attachement"
    values = [var.vpc_id]
  }
}


# Call module to creat app_tier

module "app" {
  source = "./modules/app_tier/"
  vpc_id = var.vpc_id
  name   = var.name
  ami    = var.ami
  gateway_id = data.aws_internet_gateway.default-gw.id



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
