 variable "public_subnet_ips" {
   type = list(string)
 }

variable "public_sg_id" {
  type = string
}
variable "vpc_id" {
  type = string
  nullable = false
}