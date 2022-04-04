##
# Get Oracle Linux image
##
data "oci_core_images" "test_images" {
    #Required
    compartment_id = var.tenancy_ocid
    #Optional
#    operating_system = "Oracle Linux"
#    operating_system_version = "8"
#    display_name = "Oracle-Linux-8.5-aarch64-2022.01.27-0"
    display_name = "Oracle-Linux-8.5-2022.01.24-0"
}

##
# Get the Availabity Domain for the tenancy
##
data "oci_identity_availability_domains" "ad" {
    compartment_id = var.tenancy_ocid
}

##
# Get Private Subnet available for tenancy
##
data "oci_core_subnets" "private_subnet" {
    compartment_id = var.tenancy_ocid
    display_name = var.private_subnet
}

data "oci_core_subnets" "public_subnet" {
    compartment_id = var.tenancy_ocid
    display_name = var.public_subnet
}

data "oci_load_balancer_shapes" "lb_shapes" {
    compartment_id = var.tenancy_ocid
}