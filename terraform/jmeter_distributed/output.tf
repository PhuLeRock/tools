output "Master_ip" {
  value = "ssh -i ~/Documents/sshkey/phultv.rsa  root@${aws_instance.Master.public_ip}"
}
output "Jmeter_master_private_host" {
  value = [aws_instance.Master.*.private_ip]
}

output "Jmeter_slave_private_hosts" {
  value = [aws_instance.Slave.*.private_ip]
}


output "Jmeter_slave_public_hosts" {
  value = [aws_instance.Slave.*.public_ip]
}