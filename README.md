# Terraform

Terraform is an Orchestration Tool, that is a part of infrastructure as code. It deploys the image into the cloud ( AMIs into the cloud and EC2 instance) and setups up infrastructure(VPC, networking etc), so has the image and does the networking as well.

where Chef and packer sit more on the **configuration management** site and create immutable AMIs.

Terraform sit on the **Orchestration side**. This includes the creation of networks and complex system and deploys AMIs.

••• Terraform keep track things had changed or not !!

## Commands:

••• ``` Terraform plan ``` to contact AWS >> validates the main.tf file to ensure the syntax is correct and no conflicts, as well as what it will try to do.

••• ``` Terraform apply ``` to apply on AWS >> applies and creates the resources specified in the main.tf file in the defined infrastructure.

••• ```Terraform refresh ``` used when the terraform.rfstate file becomes out of sync.


••• ```Terraform destroy ```  To destroy all resources created by Terraform.


## AMI

An AMI is a blueprint (snapshot) of an instance:
 - The operating system

 - Data and storage

 - All packages and exact



### Running Template File

 - To run template file (scripts): create a scripts folder and, create a scripts file in that repo. The filename would be {name}.sh.tpl.

 ```
 data "template_file" "init" {
   template = "${file("${path.module}/init.tpl")}"
 }

 ```


## Remote Exec

remote-exec which allows running inline commands but will need to move over key pair to allow AWS to use it to ssh into the machine to run the command. provisioner "remote-exec" should assign self.public_ip to host inside connection block.


## Load app

••• Place the IP address generated from the instance in the browser xxx.xxx.xxx.xxx

••• If the app is not running using the key_name to specified and IP generated from the instance enter the machine by running the following code into the command line: ```ssh -I ~/.ssh/key_name ubuntu@xxx.xxx.xxx.xxx ```
```
cd home/ubuntu/app
sudo npm start
```

## 2-tier architecture

••• This terraform code generated two instances, one instance contained the app (app_tier) and the other contained the database (db_tier).

••• Theses instances will be generated in AWS in the region eu-west-1, using AMI's (one which already has the app and dependencies installed onto it and the other has the database dependencies).

••• It will create a VPC, subnets, internet gateway, route table (with the association), NACLs and security groups.
