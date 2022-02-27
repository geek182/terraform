data "oci_core_images" "test_images" {
    #Required
    compartment_id = var.compartment_ocid

    #Optional
    operating_system = "Oracle Linux"
    operating_system_version = "8"
}
