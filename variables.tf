#Variable for vpc cidr range 
variable "vpc-cidr" {
  type    = string
  default = "10.0.0.0/16"
}

#Give project a name
variable "project" {
  type    = string
  default = "apache"
}

#Specify launch template ami
variable "ami" {
  type    = string
  default = "ami-04e7764922e1e3a57"
}
