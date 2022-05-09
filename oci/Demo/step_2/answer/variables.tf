variable "tenancy_ocid" {
  type = string
  description = "This is the OCID from your tenancy"
}

variable "user_ocid" {

}

variable "fingerprint"{

}

variable "private_key_path" {

}

variable "region" {
    default = "eu-amsterdam-1"
    description = "Region where we are going to work"
}

variable "ufp" {

}

variable "instance_shape" {
  default = "VM.Standard.E2.1.Micro"
}
variable private_subnet {
  default = "UFP_Private_Subnet"
}

variable public_subnet {
  default = "UFP_Public_Subnet"
}

variable "public_ip" {
  type = bool
  default = false
}

variable "network_compartment" {
  
}

variable "backendset_health_check" {
  type = map(string)
  default =  {
	port = "80"
  url = "/"
  protocol = "HTTP"
	return_code = "200"
    }
}