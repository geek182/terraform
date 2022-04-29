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
 - echo 'This instance was provisioned by Terraform.' >> /etc/motd
 - sudo yum install nginx curl -y
 - sudo systemctl enable --now nginx
 - sudo netstat -ntpl
 - sudo systemctl status nginx
 - curl -Iv http://localhost
 - firewall-offline-cmd --add-port=80/tcp
 - systemctl enable  firewalld
 - systemctl restart  firewalld
YAML
}
