terraform{
    required_providers{
        aws={
            source="hashicorp/aws"
            version="~>4"
        }
    }
}
provider "aws"{
    region="ap-south-1"
    access_key="
    secret_key="
}

module "ec2-instance"{
    source="terraform-aws-modules/ec2-instance/aws"
    name="single instance"
    ami="ami-0ad21ae1d0696ad58"
    instance_type="t2.micro"
    vpc_security_group_ids=["sg-06744cafe89daf8ae"]
    key_name="ubuntu"
    subnet_id="subnet-03243d28cda444323"
    tags={
        name="rushi"
    }
    user_data = <<-EOF
    #!/bin/bash
    sudo apt-get update
    sudo apt install -y apache2
    sudo systemctl status apache2
    sudo systemctl start apache2
    sudo chmod 777 /var/www/html
    sudo echo "<h1> hello world </h1> > /var/www/html/index.html
    EOF
}

resource "aws_security_group" "sg12" {

  ingress {
    self = true
    protocol  = "HTTP"
    from_port = 80
    to_port   = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

   ingress {
    protocol  = "TCP"
    from_port = 22
    to_port   = 22
    cidr_blocks = ["0.0.0.0/0"]
    
  }
}

