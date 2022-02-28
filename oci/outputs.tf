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
  value  = data.oci_core_subnets.private_subnet.compartment_id
}
