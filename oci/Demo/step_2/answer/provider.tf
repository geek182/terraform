##
# Terraform relies on plugins called "providers" to interact with cloud providers, SaaS providers, and other APIs.
# Each provider adds a set of resource types and/or data sources that Terraform can manage.
##

##
# Objective: Configure a provider for this demo
##

provider "oci" {
  tenancy_ocid  = var.tenancy_ocid
  user_ocid     = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.region
}