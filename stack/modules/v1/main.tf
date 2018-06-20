resource "aws_security_group" "bastion-node" {
  name        = "${var.tag_name}"
  description = "Allow all inbound traffic"

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.tag_name}"
    System = "${var.tag_system}"
  }
}
