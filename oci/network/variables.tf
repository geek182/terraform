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

variable "pre_auth_token_network" {
}

variable "config_file_profile" {

}

variable "region" {
	default = "us-ashburn-1"
	type    = string
}

# The value to this variable is coming from the environment variables "TF_VAR_root_compartment"

variable root_compartment {

}

variable network_compartment_description {
    default = "Network components"
}

variable network_name {
    default = "UnitedFederationsOfPlanets"
}

variable private_subnet_name {
    default = "UFP_Private_Subnet"
}

variable dns_label{
    default = "enterprise"
}

variable public_subnet_name {
    default = "UFP_Public_Subnet"
}

variable sg_private_subnet {
    default = "Security Group Private Subnet"
}

variable sg_public_subnet {
    default = "Security Group Public_Subnet"
}

variable internet_gateway_name {
    default = "InternetGateway"
}

variable nat_gateway_display_name{
    default = "Nat Gateway Private Network"
}

variable route_table_public_subnet {
    default = "RT for Public subnet"
}

variable route_table_private_subnet {
    default = "RT for Private subnet"
}