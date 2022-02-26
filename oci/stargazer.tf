#
# UFP = United Federations of Planets founded at 2161
#

variable "compartment_description"{
	type = string
	default = "Picard's ship before the enterprise"
}

variable "ufp" {
}

###
# Compartment used for this DEMO
##

resource "oci_identity_compartment" "stargazer"{
    compartment_id = var.ufp
    description = var.compartment_description
    name = "stargazer"
    enable_delete = true
}


##
# VCN
##

##
# Routes
##

##
# Instances
##

##
# Load balance
##

##
# Security groups
##
