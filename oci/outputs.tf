output "Private_IP" {
	value = oci_core_instance.stargazer-01.private_ip
}


output "availables_ad" {
  value       = data.oci_identity_availability_domains.ad.availability_domains[0].name
  description = "Availability Domains for this account."
}

output "images_to_use" {
  value      =  data.oci_core_images.test_images.images
}

output "subnets" {
  value  = data.oci_core_subnets.private_subnet.subnets[0].id
}

output "lb_shapes" {
  value = data.oci_load_balancer_shapes.lb_shapes.shapes[0].name
}

output "lb_public_ip" {
  value = oci_load_balancer.loadbalance_stargazer.ip_address_details
}