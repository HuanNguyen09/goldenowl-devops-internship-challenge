 variable "vpc_name" {
   type = string
 }

 variable "availability_zones" {
    type = list(any)   
 }

 variable "cidr_block" {
    type = string    
 }

 variable "public_subnet_ips" {
   type = list(string)
 }

 variable "private_subnet_ips" {
   type = list(string)
 }
 