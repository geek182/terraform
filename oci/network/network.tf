##
# Network - Building blocks
##

resource "oci_identity_compartment" "network-components"{
    compartment_id = var.root_compartment
    description = var.network_compartment_description
    name = "network-components"
    enable_delete = true
}

resource "oci_core_vcn" "ufp" {
  cidr_blocks     = ["10.1.0.0/16"]
  compartment_id = oci_identity_compartment.network-components.id # TODO use a separate compartment for network 
  display_name   = var.network_name
  dns_label      = var.dns_label
}

resource "oci_core_subnet" "private_subnet" {
  cidr_block        = "10.1.20.0/24"
  display_name      = var.private_subnet_name
  security_list_ids = [oci_core_security_list.private_subnet_security_list.id]
  compartment_id    = oci_identity_compartment.network-components.id
  vcn_id            = oci_core_vcn.ufp.id
  route_table_id    = oci_core_route_table.route_table_private_subnet.id
  dhcp_options_id   = oci_core_vcn.ufp.default_dhcp_options_id
}

resource "oci_core_subnet" "public_subnet" {
  cidr_block        = "10.1.21.0/24"
  display_name      = var.public_subnet_name
  security_list_ids = [oci_core_security_list.public_subnet_security_list.id]
  compartment_id    = oci_identity_compartment.network-components.id
  vcn_id            = oci_core_vcn.ufp.id
  route_table_id    = oci_core_route_table.route_table_public_subnet.id
  dhcp_options_id   = oci_core_vcn.ufp.default_dhcp_options_id
}

resource "oci_core_security_list" "private_subnet_security_list" {
  compartment_id = oci_identity_compartment.network-components.id
  vcn_id         = oci_core_vcn.ufp.id
  display_name   = var.sg_private_subnet

  egress_security_rules {
    protocol    = "6"
    destination = "0.0.0.0/0"
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      max = "22"
      min = "22"
    }
  }



  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      max = "80"
      min = "80"
    }
  }
}

resource "oci_core_security_list" "public_subnet_security_list" {
  compartment_id = oci_identity_compartment.network-components.id
  vcn_id         = oci_core_vcn.ufp.id
  display_name   = var.sg_public_subnet

  egress_security_rules {
    protocol    = "6"
    destination = "0.0.0.0/0"
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      max = "80"
      min = "80"
    }
  }
}

resource "oci_core_internet_gateway" "ufp_internet_gateway" {
  compartment_id = oci_identity_compartment.network-components.id
  display_name   = var.internet_gateway_name
  vcn_id         = oci_core_vcn.ufp.id
}

# The limit for free tier doesn't allow to create a new nat gateway
# Confirming as per private conversation, NAT servers are not available under always free period.

# resource "oci_core_nat_gateway" "ufp_nat_gateway" {
#     compartment_id = oci_identity_compartment.network-components.id
#     vcn_id = oci_core_vcn.ufp.id
#     #block_traffic = var.nat_gateway_block_traffic #TODO check if I should enable this option
#     display_name = var.nat_gateway_display_name
# }

resource "oci_core_route_table" "route_table_public_subnet" {
  compartment_id = oci_identity_compartment.network-components.id
  vcn_id         = oci_core_vcn.ufp.id
  display_name   = var.route_table_public_subnet

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.ufp_internet_gateway.id
  }
}

resource "oci_core_route_table" "route_table_private_subnet" {
  compartment_id = oci_identity_compartment.network-components.id
  vcn_id         = oci_core_vcn.ufp.id
  display_name   = var.route_table_private_subnet

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.ufp_internet_gateway.id
  }
}