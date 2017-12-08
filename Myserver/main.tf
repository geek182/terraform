##Using assume role to auth
provider "aws" {
  region  = "${var.region}"
  profile = "nameofprofiler"
  assume_role {
    role_arn     = "rolearn"
    session_name = "terraform"
  }
}

resource "aws_instance" "MySuperServer" {
  ami = "ami-25661049"
  instance_type = "t2.micro"
  key_name = "${var.key_name}"
  subnet_id = "${var.subnet_id}"
}