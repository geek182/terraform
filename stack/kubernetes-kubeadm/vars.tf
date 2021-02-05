variable "ami-id" {
	default = "ami-0f65671a86f061fcd"
}

variable "instance-type" {
	default = "t2.micro"
}

variable "subnet-id" {
	default = ""
}

variable "key-name" {
	default = ""
}

variable "security-groups" {
	default = ["sg,sg"]
}

variable "name-worker" {
	default = "WORKER"
}

variable "name-master"{
	default = "MASTER"
}
