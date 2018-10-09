resource "aws_autoscaling_group" "generic-asg" {
 name                    = "${var.name}"
 max_size                = "${var.max_size}"
 min_size                = "${var.min_size}"
 desired_capacity        = "${var.desired_capacity}"
 health_check_type       = "${var.hc_type}"
 launch_template         = { 
 id                      = "${aws_launch_template.generic_lc_template.id}" 
 version                 = "$$Latest"		 	    
}
 vpc_zone_identifier     = ["${var.subnets}"]

}

resource "aws_launch_template" "generic_lc_template" {
 name                    = "lc-${var.name}"
 key_name                = "${var.key_name}"
 image_id                = "${var.image_id}"
 
}
