##
# Get the Availabity Domain for the tenancy
##
data "oci_identity_availability_domains" "ad" {
    compartment_id = var.tenancy_ocid
}

data "oci_core_images" "oracle_linux_images" {
    #Required
    compartment_id = var.tenancy_ocid
    #Optional
#    operating_system = "Oracle Linux"
#    operating_system_version = "8"
#    display_name = "Oracle-Linux-8.5-aarch64-2022.01.27-0"
    display_name = "Oracle-Linux-8.5-2022.01.24-0"
}

data "oci_core_subnets" "public_subnet" {
    compartment_id = var.cp_network_components_ocid
    display_name = var.subnet_display_name
}

data "template_file" "cloud-config" {
  template = <<YAML
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
YAML
}
