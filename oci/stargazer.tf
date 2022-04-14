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

resource "oci_load_balancer" "loadbalance_stargazer" {
  shape          = data.oci_load_balancer_shapes.lb_shapes.shapes[0].name # only LB shape available for free resources "flexible"
  shape_details {
    maximum_bandwidth_in_mbps = 10
    minimum_bandwidth_in_mbps = 10
  }
  compartment_id = oci_identity_compartment.stargazer.id

  subnet_ids = [
    data.oci_core_subnets.public_subnet.subnets[0].id,
  ]

  display_name               = "lb_stargazer"
  is_private                 = false
  #network_security_group_ids = [oci_core_network_security_group.test_network_security_group.id]
}

##
# Load Balance set
##

resource "oci_load_balancer_backend_set" "loadbalance_set_stargazer" {
  name             = "lbset_stargazer"
  load_balancer_id = oci_load_balancer.loadbalance_stargazer.id
  policy           = "ROUND_ROBIN"

  health_checker {
    port                = var.backendset_health_check["port"]
    protocol            = var.backendset_health_check["protocol"]
    url_path            = var.backendset_health_check["url"]
    return_code         = var.backendset_health_check["return_code"]
  }
}

#
# Load Balance backend 
#

resource "oci_load_balancer_backend" "backend_stargazer" {
  #Required
  backendset_name  = oci_load_balancer_backend_set.loadbalance_set_stargazer.name
  ip_address       = oci_core_instance.stargazer-01.private_ip
  load_balancer_id = oci_load_balancer.loadbalance_stargazer.id
  port             = var.backend_stargazer_port
}

#
# Security groups
#
