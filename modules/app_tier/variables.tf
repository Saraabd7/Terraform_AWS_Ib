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
