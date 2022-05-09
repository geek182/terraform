#
# The USS Stargazer (NCC-2893) was a 24th century Federation Constellation-class starship operated by Starfleet
# "Hello, old friend."
#    – Jean-Luc Picard
#

##
# Objective:
#  - Terraform state
#  - Using Data sources
#  - Using Output variables
##

resource "oci_core_instance" "stargazer" {
    display_name = "stargazer-DEMO-01"
    availability_domain = data.oci_identity_availability_domains.ad.availability_domains[0].name
    compartment_id = var.ufp
    shape = var.instance_shape

    create_vnic_details {
      subnet_id = data.oci_core_subnets.private_subnet.subnets[0].id
      assign_public_ip = var.public_ip
    }
    source_details {
      source_id = data.oci_core_images.oracle_images.images[0].id
      source_type = "image"
    }
    metadata = {
      "user_data" = "${base64encode(<<-EOT
#cloud-config
runcmd:
 - sudo yum install nginx curl -y
 - sudo systemctl enable --now nginx
 - sudo systemctl status nginx
 - sudo rm /usr/share/nginx/html/index.html
 - echo '<html><head><title> DEMO for the Guild </title></head><body><center><h1><b>To boldy go where no one has gone before</b></h1></center></body></html>' >> /usr/share/nginx/html/index.html
 - firewall-offline-cmd --add-port=80/tcp
 - systemctl enable  firewalld
 - systemctl restart  firewalld
  EOT
  ) }"

    }

}

##
# Deep Space Nine' is set on a space station orbiting the planet Bajor.
# The crew must fight off rival alien species who want control of Deep Space Nine because 
# of its strategic position close to a wormhole, which allows speedy travel to the far reaches of space.
##
resource "oci_load_balancer" "DeepSpaceNine" { 
 display_name               = "LB_DeepSpaceNine"
 is_private                 = false
 shape = "flexible"
 shape_details {
    maximum_bandwidth_in_mbps = 10
    minimum_bandwidth_in_mbps = 10
  }
 compartment_id = var.ufp
 subnet_ids = [ data.oci_core_subnets.public_subnet.subnets[0].id,
 ]
}

resource "oci_load_balancer_backend_set" "Loadbalancer_Set_DeepSpaceNine" {
  name = "LB_Set_DeepSpaceNine"
  load_balancer_id = oci_load_balancer.DeepSpaceNine.id
  policy = "ROUND_ROBIN"
  health_checker { 
    port                = var.backendset_health_check["port"]
    protocol            = var.backendset_health_check["protocol"]
    url_path            = var.backendset_health_check["url"]
    return_code         = var.backendset_health_check["return_code"]
  }
}

resource "oci_load_balancer_listener" "LoadBalancer_listener_DeepSpaceNine"{
  load_balancer_id         = oci_load_balancer.DeepSpaceNine.id
  name                     = "http"
  default_backend_set_name = oci_load_balancer_backend_set.Loadbalancer_Set_DeepSpaceNine.name
  port                     = 80
  protocol                 = "HTTP"
  #rule_set_names           = [oci_load_balancer_rule_set.test_rule_set.name]

  connection_configuration {
    idle_timeout_in_seconds = "240"
  }
}   

resource "oci_load_balancer_backend" "Backend_DeepSpaceNine" {
    backendset_name = oci_load_balancer_backend_set.Loadbalancer_Set_DeepSpaceNine.name
    ip_address = oci_core_instance.stargazer.private_ip
    load_balancer_id = oci_load_balancer.DeepSpaceNine.id
    port = var.backendset_health_check["port"]
}