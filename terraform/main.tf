provider "aws" {
  region = "eu-central-1"
}


# security_group

resource "aws_security_group" "sec_group" {
  name = "sec_group"
  description = "security group "
  tags = {
    Name = "HTTP-SSH"
  }

  ingress {
    description = "HTTP (8080)"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "(9323)"
    from_port   = 9323
    to_port     = 9323
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "(3000)"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "(9100)"
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "(9090)"
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH (22)"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



resource "aws_key_pair" "tf-key-pair" {
key_name = "tf-key-pair"
public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
algorithm = "RSA"
rsa_bits  = 4096
}
resource "local_file" "tf-key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "tf-key-pair.pem"
  file_permission = "0400"
}


resource "aws_instance" "server" {
    ami = "ami-0ab1a82de7ca5889c"
    instance_type = "t2.micro"
    key_name = "tf-key-pair"
    associate_public_ip_address = true
    vpc_security_group_ids = [ aws_security_group.sec_group.id ]

    tags = {
            Name = "server"
    }

  provisioner "remote-exec" {
    inline = ["sudo hostname"]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(local_file.tf-key.filename)
//      private_key = "./tf-key-pair.pem"
      host = aws_instance.server.public_ip
    }
  }
  provisioner "local-exec" {
    command = "ansible-playbook -i ./ec2.py ../ansible/playbook_server.yml --private-key ./tf-key-pair.pem"
  }
}

resource "aws_instance" "client" {
    ami = "ami-0ab1a82de7ca5889c"
    instance_type = "t2.micro"
    key_name = "tf-key-pair"
    associate_public_ip_address = true
    vpc_security_group_ids = [ aws_security_group.sec_group.id ]

    tags = {
            Name = "client"
    }

  provisioner "remote-exec" {
    inline = ["sudo hostname"]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(local_file.tf-key.filename)
//      private_key = "./tf-key-pair.pem"
      host = aws_instance.client.public_ip
    }
  }

  provisioner "local-exec" {
    command = "ansible-playbook -i ./ec2.py ../ansible/playbook_client.yml --private-key ./tf-key-pair.pem"
  }
}

output "client_ip" {
  value = ["${aws_instance.client.public_ip}"]
}

output "server_ip" {
  value = ["${aws_instance.server.public_ip}"]
}