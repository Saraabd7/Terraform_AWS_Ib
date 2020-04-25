# Terraform 🔥

Terraform is an Orchestration Tool, that is a part of infrastructure as code.
** It deploy AMIs into the cloud.

** Terraform is orchestration tool that deploys the image into cloud (for example ec2 instance) and setups up infrastructure(vpc, networking etc), so has the image and does the networking as well.

where Chef and packer sit more on the **configuration management** site and create immutable AWIs.

Terraform  sit on the **Orchestration side**. This include the creation  of networks and complex system and deploys AMIs.

## Commands:

```
terraform init
```
```
terraform plan
```
```
terraform apply
```

••• Terraform keep track things had change or not !!

••• ``` Terraform plan ``` to contact aws >> validates the main.tf file to ensure the syntax is correct and no conflicts, as well as what it will try to do.

••• ``` Terraform apply ``` to apply on aws >> applies and creates the resources specified in the main.tf file in the defined infrastructure.

••• ```Terraform refresh ``` used when the terraform.rfstate file becomes out of sync.
An AMI is a blue print (snap shot) of an instance:
 - The operating system

 - Data and storage

 - All packages and exact

 • state of a machine when AMI was created.

 - Dynamical change the name ```terraform plan -var 'name=bob'```

 •• bob is the name that we are changing another example:: ```terraform plan -var 'name=long-name'```
 In our stack we have:



• Chef is configuration management tool and sets up the machine and can provision it (e.g recipes, metadata, berks_cookbook, unit and spec tests, kitchen.yml and more)


• Packer  creates an immutable image of that machine




Using the key_name to specified and ip generated from the instance enter the machine by running the following code into the command line: ```ssh -i ~/.ssh/key_name ubuntu@xxx.xxx.xxx.xxx ```

```
cd home/ubuntu/app
sudo npm install
sudo npm start

```
