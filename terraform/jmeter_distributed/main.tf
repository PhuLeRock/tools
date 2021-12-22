resource "aws_security_group" "sg_Jmeter_distributed" {
  name        = "sg_Jmeter_distributed"
  description = "Allow web and ssh traffic"
  vpc_id      = var.vpc
  #SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  #HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }  
  #HTTPS
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  #Jmeter
  ingress {
    from_port   = 50000
    to_port     = 50000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 60000
    to_port     = 60000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 1099
    to_port     = 1099
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8090
    to_port     = 8090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }          
  #Outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "Master" {

  tags = {
    Name = var.name_master
    createdby = var.createdby
  }
  instance_type = var.instance_type
  ami           = var.ami
  associate_public_ip_address = "true"
 
  user_data = <<EOF
#!/bin/bash
echo "yes, I'm here" >> /root/user_data.log
sudo apt-get install  curl  apt-transport-https ca-certificates software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add 
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" 
sudo apt-get update 
sudo apt-get install -y docker-ce 
sudo usermod -aG docker $USER 
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose 
sudo chmod +x /usr/local/bin/docker-compose 
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
docker pull dragoscampean/testrepo:jmetrumaster
docker pull dragoscampean/testrepo:jmetruslave
HostIP=$(ip route show | awk '/default/ {print $9}')
docker run -dit --name master --network host -e HostIP=$HostIP -e Xms=256m -e Xmx=512m -e MaxMetaspaceSize=512m -v /opt/Sharedvolume:/opt/Sharedvolume dragoscampean/testrepo:jmetrumaster /bin/bash
docker run -dit --name slave --network host -e HostIP=$HostIP -e Xms=256m -e Xmx=512m -e MaxMetaspaceSize=512m dragoscampean/testrepo:jmetruslave /bin/bash
cat /home/ubuntu/.ssh/authorized_keys > /root/.ssh/authorized_keys
echo ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCkUls/JN5Jlv3wdSliF86Z5HEBLm1QiqX9/oJDLCte26Towk9dLaqBihyqEQtDbHWqoZDUfg8LZW65A56u2MXu4duPNa+cFSu6hcnpmQX4jpKnMOYsAD349LqOExl6Oge+/tc9PwU+t5xlsNTjGGMTtTCEZUnrWnHcPIdIlXC0IpVJik7x5qNMTZ4zxtc9OzMeIRXjtcUrmHbVNP8IsofzpRFSWZ6scB6Jwue9bskvMl2gENxkcd1blUclJqCQGXEX/4zvImtj/RmqlXBDPAbWjqLMAwKBwHCT5sOY3AT3NVrcs4IhCnksIR4AWKobWX///dnxtZGtEoQ1FigZGCBeQUh9DezALMBG1UhiTBe/Cz4ryQh18/z1rq53T+fgvGbKtQdkAALJtPH9j18lV0fYOGpvp36pjNJS+oC7xMhoLE2nvcVKNumw443Lt1NTrwTrEmLbsUIIF1fV1XZUSlwkxuEU+dVvjpXQZ89fFm6+4aHEqwntDJsHlM824OJX+Yk= tester >> /root/.ssh/authorized_keys
echo "end of file" >> /root/user_data.log
  EOF
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.sg_Jmeter_distributed.id]
  subnet_id              = var.RedShiftDev02
}

################

resource "aws_instance" "Slave" {
  count = var.number_of_slave
  tags = {
    Name = "${var.name_slave}_${count.index +1}"
    createdby = var.createdby
  }
  instance_type = var.instance_type
  ami           = var.ami
  associate_public_ip_address = "true"
 
  user_data = <<EOF
#!/bin/bash
echo "yes, I'm here" >> /root/user_data.log
sudo apt-get install  curl  apt-transport-https ca-certificates software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add 
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" 
sudo apt-get update 
sudo apt-get install -y docker-ce 
sudo usermod -aG docker $USER
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose 
sudo chmod +x /usr/local/bin/docker-compose 
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
docker pull dragoscampean/testrepo:jmetrumaster
docker pull dragoscampean/testrepo:jmetruslave
HostIP=$(ip route show | awk '/default/ {print $9}')
docker run -dit --name slave01 --network host -e HostIP=$HostIP -e Xms=256m -e Xmx=512m -e MaxMetaspaceSize=512m dragoscampean/testrepo:jmetruslave /bin/bash
echo "end of file" >> /root/user_data.log
  EOF
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.sg_Jmeter_distributed.id]
  subnet_id              = var.RedShiftDev02
}




