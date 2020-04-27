variable "vpc_id" {
  description = "The vpc it launches  resources into"
}


variable "name" {
  description = "tags"
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
#
# variable "pub_ip" {
#   description = "the generated ip"
# }
#
# variable "db_instance-ip" {
#   description = "the ip of the db instance"
# }
