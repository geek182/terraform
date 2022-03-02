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

variable "quota_name" {
	default = "Julius_Rock"
	description = "Chris Rock's father"
}

variable "quota_description"{
	default = "Unplug that clock, boy. You can't tell time while you sleep. That's two cents an hour."
}

variable "quota_statements" {
	default = [
		"set compute quota vm-dense-io2-8-count to 0 in tenancy",
		 "set compute quota bm-standard1-36-count to 0 in tenancy",
		 "set compute quota bm-standard-b1-44-count to 0 in tenancy",
		 "set compute quota bm-standard2-52-count to 0 in tenancy",
		 "set compute quota bm-standard-e2-64-count	to 0 in tenancy",
		 "set compute quota bm-dense-io1-36-count to 0 in tenancy",
		 "set compute quota bm-dense-io2-52-count to 0 in tenancy",
		 "set compute quota bm-gpu2-2-count to 0 in tenancy",
		 "set compute quota bm-gpu3-8-count to 0 in tenancy",
		 "set compute quota bm-hpc2-36-count to 0 in tenancy",
		 "set compute quota vm-standard1-1-count to 0 in tenancy",
		 "set compute quota vm-standard1-2-count to 0 in tenancy",
		 "set compute quota vm-standard1-4-count to 0 in tenancy",
		 "set compute quota vm-standard1-8-count to 0 in tenancy",
	]
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