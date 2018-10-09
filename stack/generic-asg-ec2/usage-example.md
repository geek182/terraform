#main.tf  
provider "aws" {  
 region = "us-east-2"  
 profile = "someprofile" #alternative below  
 assume_role {  
 role_arn = "arn:aws:iam::IDACCOUNT:role/role-name"  
}  
 
}  


module "asg" {  
 source = "../path/to/module/generic-asg-ec2"  
 name = "generic-server"  
 subnets = ["subnet-1", "subnet-2"]  
}

