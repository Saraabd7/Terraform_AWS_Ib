# Terraform 🔥

Terraform is an Orchestration Tool, that is a part of infrastructure as code.
** It deploys AMIs into the cloud.

** Terraform is an orchestration tool that deploys the image into the cloud (for example EC2 instance) and setups up infrastructure(VPC, networking etc), so has the image and does the networking as well.

where Chef and packer sit more on the **configuration management** site and create immutable AWIs.

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

 • state of a machine when AMI was created.

 - Dynamical change the name ```terraform plan -var 'name=bob'```

 •• bob is the name that we are changing another example:: ```terraform plan -var 'name=long-name'```



### Running Template File

 •• scripts

 - To run scripts: create a scripts folder and, create a scripts file in that repo. The filename would be {name}.sh.tpl.

 ```
 data "template_file" "init" {
   template = "${file("${path.module}/init.tpl")}"
 }

 ```

## Remote Exec

remote-exec which allows running inline commands but will need to move over key pair to allow AWS to use it to ssh into the machine to run the command. provisioner "remote-exec" should assign self.public_ip to host inside connection block.


••• Using the key_name to specified and IP generated from the instance enter the machine by running the following code into the command line: ```ssh -I ~/.ssh/key_name ubuntu@xxx.xxx.xxx.xxx ```

```
cd home/ubuntu/app
sudo npm start
```
