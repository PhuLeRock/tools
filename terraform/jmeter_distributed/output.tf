output "Master_ip" {
  value = "ssh -i ~/Documents/sshkey/phultv.rsa  root@${aws_instance.Master.public_ip}"
}

output "Jmeter_hosts" {
  value = [aws_instance.Master.*.private_ip, aws_instance.Slave.*.private_ip]
}
