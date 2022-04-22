
profile configuration

provider "oci" {
  config_file_profile = var.config_file_profile
}

and inside the oci file ~/.oci/config

[DEFAULT]
user=ocid1.user.oc1..<unique_ID>
fingerprint=<your_fingerprint>
key_file=~/.oci/oci_api_key.pem
tenancy=ocid1.tenancy.oc1..<unique_ID>
region=us-ashburn-1

[ADMIN_USER]
user=ocid1.user.oc1..<unique_ID>
fingerprint=<your_fingerprint>
key_file=keys/admin_key.pem
pass_phrase=<your_passphrase>

now you can call the terraform specifing the profile to use:

terraform plan -var config_file_profile="ADMIN_USER"

or leave blank for using the default

terraform plan -var config_file_profile=""