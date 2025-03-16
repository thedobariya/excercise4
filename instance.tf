resource "aws_instance" "web" {
  ami = var.amiID[var.region]
  #   key_name = aws_key_pair.dove-key.key_name
  key_name               = "dove-key"
  vpc_security_group_ids = [aws_security_group.dove-sg.id]
  instance_type          = "t3.micro"
  availability_zone      = var.zone1
  tags = {
    Name    = "Dove-web"
    Project = "Dove"
  }

  connection {
    type        = "ssh"
    user        = var.webuser
    private_key = file("dovekey")
    host        = self.public_ip
  }

  provisioner "file" {
    source      = "web.sh"
    destination = "/tmp/web.sh"
  }


  provisioner "remote-exec" {

    inline = [
      "sudo chmod +x /tmp/web.sh",
      "sudo /tmp/web.sh",
    ]
  }
}

resource "aws_ec2_instance_state" "web-state" {
  instance_id = aws_instance.web.id
  state       = "running"
}