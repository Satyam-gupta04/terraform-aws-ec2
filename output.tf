## This will allow you to retrieve the public IP, public DNS , private IP , private DNS of EC2 instance 

output "ec2_public_ip" {
    value = aws_instance.my_instance.public_ip     ## we can also used [*] to get the public IP of multiple instances 
}

output "ec2_public_dns" {
    value = aws_instance.my_instance.public_dns    ## we can also used [*] to get the public IP of multiple instances 
}

output "ec2_private_ip" {
    value = aws_instance.my_instance.private_ip    ## we can also used [*] to get the public IP of multiple instances 
}

## We use this output to get for multiple instances of different names 
# output "bd_name" {
#   value = [
#     for key in aws_instance.my_instance : key.name
#   ]
# }
