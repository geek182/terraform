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

variable  "image_id"{
 default = "ami-0e4c9b46b89ddd90c" 
}
