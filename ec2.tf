
# key-pair

resource "aws_key_pair" "my_key" {
    key_name = "terra_key_new"
    public_key = file("terra_ec2_key.pub")
}

#vpc

resource "aws_default_vpc" "default" {


}

#security group
resource "aws_security_group" "my_SG1" {
    name = "TF Generated SG1_new"
    description = "This will add TF Generated SG"
    vpc_id = aws_default_vpc.default.id #interpolation

    #inbound Rules
    ingress{
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "SSH Open"

    }
    ingress{
        from_port = 80
        to_port = 80
        cidr_blocks = ["0.0.0.0/0"]
        protocol = "tcp"
        description = "HTTP Open"
    }

    #outbound Rules
    egress{
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0" ]
        description = "All Access"

    }
    tags = {
      Name ="Automate SG"
    }
}

  #EC2 instance

  resource "aws_instance" "Terra_EC2" {
    for_each = tomap({
      Nilam-Automate-micro = "t2.micro",
      Nilam-Automated-micro1 = "t2.micro"

    })

    

    key_name        = aws_key_pair.my_key.key_name
    security_groups = [aws_security_group.my_SG1.name]
    instance_type   = each.value
    ami             = var.ami_id
    user_data       = file("install_nginx.sh")
    
    root_block_device {
      volume_size = var.env == "prd" ? 20 : var.aws_default_root_storage_size
      volume_type = "gp3"
    }
    tags = {
      Name = each.key
    }
  }

 