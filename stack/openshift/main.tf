/*
Leandro Azevedo
@geek182
*/

module "ec2_sg" {
  source   = "../modules/v1"
  vpc_id   = "123"
  tag_name = "SG-${var.tag_name}"
}
