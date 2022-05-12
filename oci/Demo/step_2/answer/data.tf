data "oci_identity_availability_domains" "ad" {
    compartment_id = var.tenancy_ocid
}

data "oci_core_subnets" "private_subnet" {
    compartment_id = var.network_compartment
    display_name = var.private_subnet
}

data "oci_core_subnets" "public_subnet" {
    compartment_id = var.network_compartment
    display_name = var.public_subnet
}
data "oci_core_images" "oracle_images" {
    compartment_id = var.tenancy_ocid
    #display_name = "Oracle-Linux-8.5-2022.01.24-0"
    display_name = "Oracle-Linux-8.5-2022.04.26-0"
}