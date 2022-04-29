output "availables_ad" {
  value       = data.oci_identity_availability_domains.ad.availability_domains
  description = "Availability Domains for this account."
}

output "oracle_linux" {
  value = data.oci_core_images.oracle_linux_images.images[0].id
}

output "public_subnets" {
  value  = data.oci_core_subnets.public_subnet.subnets[0].display_name
}

output "public_ip" {
  value = oci_core_instance.stargazer-01.public_ip
}

