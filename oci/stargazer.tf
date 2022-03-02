
##
# Making sure you won't spend all your money with some labs :)
##

resource "oci_limits_quota" "tenancy_quota" {
    #Required
    compartment_id = var.tenancy_ocid
    description = var.quota_description
    name = var.quota_name
    statements = var.quota_statements
}
###
# Compartment used for this DEMO
##

resource "oci_identity_compartment" "stargazer"{
    compartment_id = var.ufp
    description = var.compartment_description
    name = "stargazer"
    enable_delete = true
}


##
# VCN
##

##
# Routes
##

##
# Instances
##

resource "random_string" "server" {
    length = 4
    min_upper= 0 #no upper characters in the name
}

resource "oci_core_instance" "stargazer-01" {
    depends_on = [oci_identity_compartment.stargazer]
    display_name = "stargazer-${random_string.server.id}"
    availability_domain =  data.oci_identity_availability_domains.ad.availability_domains[1].name
    compartment_id =   oci_identity_compartment.stargazer.id
    shape = var.instance_shape
    create_vnic_details {
	#subnet_id = data.oci_core_subnets.private_subnet.compartment_id
    subnet_id = data.oci_core_subnets.private_subnet.subnets[0].id #subnets - The list of subnets.
    assign_public_ip = "false"
	}
    source_details {
	source_id =  data.oci_core_images.test_images.images[0].id
        source_type = "image"
	}
}

##
# Load balance
##

##
# Security groups
##
