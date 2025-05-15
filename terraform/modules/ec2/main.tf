
variable "project" {}
variable "estagiarios" {
  type = list(string)
}
variable "subnet_id" {}
variable "sg_id" {}

resource "aws_instance" "ec2_estagiarios" {
  count         = length(var.estagiarios)
  ami           = "ami-0866a3c8686eaeeba" // Ubuntu Server 24.04 LTS
  instance_type = "t3.medium"
  subnet_id     = var.subnet_id
  vpc_security_group_ids = [var.sg_id]

  tags = {
    Name  = "${var.project}-${var.estagiarios[count.index]}"
    Owner = var.estagiarios[count.index]
  }

  user_data = <<-EOF
        #!/bin/bash
        apt-get update -y
        apt-get install nginx -y
        systemctl start nginx
        systemctl enable nginx

        apt install postgresql-client -y
    EOF
}

output "ec2_public_dns" {
  value = [for instance in aws_instance.ec2_estagiarios : instance.public_dns]
}