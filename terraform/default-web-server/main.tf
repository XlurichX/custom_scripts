# Create EC2-inst
resource "aws_instance" "web-server" {
    ami = var.ami_id # id debian 12
    instance_type = var.instance_type # type inst
    tags = {
        Name = "WebServer"
    }
    key_name = aws_key_pair.my_key.key_name # use ssh key 
    security_groups = [aws_security_group.web_server_sg.name]
    
    provisioner "remote-exec" {
        inline = [
            "sudo apt update",
            "sudo apt install nginx -y",
            "sudo systemctl restart nginx"
        ]
        
        connection {
            type = "ssh"
            user = "admin" #default username ami debian 
            private_key = file("/root/.ssh/id_ed25519")
            host = aws_instance.web-server.public_ip
        }
    }
}

# Create ssh key
resource "aws_key_pair" "my_key" {
    key_name = "my_key"
    public_key = file("/root/.ssh/id_ed25519.pub")
}

# Create Sec.Group
resource "aws_security_group" "web_server_sg" {
    name_prefix = "web-sg-"

    # Allow ports 
    ingress {
        from_port = var.server_http_port
        to_port = var.server_http_port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        }
    ingress {
        from_port = var.server_https_port
        to_port = var.server_https_port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        }
    ingress {
        from_port = var.server_ssh_port
        to_port = var.server_ssh_port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        }
    egress {
        from_port = var.out_port
        to_port = var.out_port
        protocol = "-1" # -1 - all 
        cidr_blocks = ["0.0.0.0/0"]
    }
}
