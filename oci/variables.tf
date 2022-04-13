variable "tenancy_ocid" {
}

variable "user_ocid" {
}

variable "fingerprint" {
}

variable "private_key_path" {
}

variable "private_key_password"{
}

variable "region" {
	default = "us-ashburn-1"
	type    = string
}

#variable "compartment_ocid" {
#}

#
# UFP = United Federations of Planets founded at 2161
#

variable "compartment_description"{
	type = string
	default = "Picard's ship before the enterprise"
}

variable "ufp" {
}

variable instance_shape {
	#default = "VM.Standard.A1.Flex" Not available at the moment
	default = "VM.Standard.E2.1.Micro"
}


##
# Network
##

variable private_subnet{
	default = "SB-10.0.1.0"
}
variable public_subnet{
	default = "SBP-10.0.10.0"
}

##
# Stargazer variables
# The USS Stargazer NCC-2893 was a Federation Constellation-class starship operated by Starfleet during the 23rd century
##


variable backend_stargazer_port {
	description = "The listening port on the instance"
	default     = 80
}