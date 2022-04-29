#
# The USS Stargazer (NCC-2893) was a 24th century Federation Constellation-class starship operated by Starfleet
# "Hello, old friend."
#    – Jean-Luc Picard
#



resource "oci_core_instance" "stargazer-01" {
    display_name = "stargazer-DEMO"
    availability_domain =  data.oci_identity_availability_domains.ad.availability_domains[0].name
    compartment_id =   var.ufp
    shape = var.instance_shape
    metadata = {
    user_data = "${base64encode(data.template_file.cloud-config.rendered)}"
  }
    create_vnic_details {
	
    subnet_id = data.oci_core_subnets.public_subnet.subnets[0].id
    assign_public_ip = "true"
	}
    source_details {
	source_id =  data.oci_core_images.oracle_linux_images.images[0].id
        source_type = "image"
	}
}