variable "name" {
 default = ""
}

variable "max_size"{
 default = 1
}

variable "min_size"{
 default = 1
}

variable "desired_capacity" {
 default = 1
}

variable "hc_type" {
 default = "EC2"
}

variable "subnets" {
 default = []
}

variable  "key_name" {
 default = "test"
}

variable  "ami_id"{
 default = "ami-0e4c9b46b89ddd90c"
}

variable "instance_type" {
 default = "t2.medium"
}

variable "vpc_security_group_ids" {
 default = [""]
}

