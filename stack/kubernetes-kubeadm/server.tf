provider "aws" {
  profile = "vrdev"
  region = "us-east-2"
}

data "template_file" "init" {
  template = "${file("user-data.sh")}"
}
resource "aws_instance" "master" {
#ami = "ami-03c6239555bb12112"
#ami = "ami-0f65671a86f061fcd"
ami = "${var.ami-id}"
instance_type = "${var.instance-type}"
subnet_id = "${var.subnet-id}"
key_name = "${var.key-name}"
security_groups = "${var.security-groups}"

user_data = "${data.template_file.init.rendered}"
tags {
  Name = "{$var.name-master}"
}

 #provisioner "local-exec" {
 #   command = "echo ${aws_instance.master.private_ip} >> private_ips.txt"
 # }
# provisioner "local-exec" {
#    command = "sleep 60; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -e 'ansible_python_interpreter=/usr/bin/python3' -u ubuntu --private-key /home/lazevedo/Documents/KEYS/VR-CLOUD-TEAM.ppk -i '${aws_instance.master.private_ip}', /home/lazevedo/Documents/repo/terraform-geek182/stack/kubernetes-kubeadm/playbook.yml"
#   }
}




resource "aws_instance" "worker1" {
ami = "${var.ami-id}"
instance_type = "${var.instance-type}"
subnet_id = "${var.subnet-id}"
key_name = "${var.key-name}"
security_groups = "${var.security-groups}"
user_data = "${data.template_file.init.rendered}"
tags {
  Name = "${var.name-worker}"
}

}
