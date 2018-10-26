/* Criação do cluster */
resource "aws_ecs_cluster" "cluster_name" {
  name = "${var.cluster_name}"
}
