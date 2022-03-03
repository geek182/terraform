
##
# Making sure you won't spend all your money with some labs :)
##

resource "oci_limits_quota" "tenancy_quota" {
    #Required
    compartment_id = var.tenancy_ocid
    description = var.quota_description
    name = var.quota_name
    statements = var.quota_statements
}
