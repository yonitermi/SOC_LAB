output "instance_public_ip" {
  value = aws_eip.soc_lab_eip.public_ip
}
