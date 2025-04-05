/*output "ec2_public_ip" {
    value = aws_instance.Terra_EC2[*].public_ip
  }

output "ec2_public_dns" {
  value = aws_instance.Terra_EC2[*].public_dns
  
  }
output "ec2_private_ip" {
  value = aws_instance.Terra_EC2[*].private_ip
}*/

#Output for for_each
output "ec2_public_ip" {
  value = [
    for key in aws_instance.Terra_EC2 : key.public_ip
  ]
}