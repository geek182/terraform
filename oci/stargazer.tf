
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



resource "oci_core_instance" "stargazer-01" {
    availability_domain =  data.oci_identity_availability_domains.ad.availability_domains[1].name
    compartment_id =   oci_identity_compartment.stargazer.id
    shape = var.instance_shape
    create_vnic_details {
	subnet_id = data.oci_core_subnets.private_subnet.compartment_id
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
