variable "vpc_id" {
  description = "The vpc it launches resources into"
}


variable "name" {
  description = "app name"
}

variable "ami" {
  description = "ami"
}

variable "gateway_id" {
  description = "The internet gateway id"
}

variable "my_name" {
  default = "This is my name Sara"
}


variable "db_instance_ip" {
  description = "ip of the db instance"
}
