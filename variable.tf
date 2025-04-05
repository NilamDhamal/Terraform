variable "aws_instance_type" {
    default = "t2.micro"
    type = string
  
}
variable "aws_default_root_storage_size" {
    default = 8
    type = number
  
}
variable "ami_id" {
    default = "ami-03fd334507439f4d1"
    type = string
  
}
variable "env" {
    default = "dev"
    type = string
  
}