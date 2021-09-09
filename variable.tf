#VPC-cird
variable "vpc-cidr" {
  default = "10.0.0.0/16"
  description = "VPC CIDR Block"
  type = string 
}

#public-subnet-1
variable "public-subnet-1-cidr" {
  default = "10.0.0.0/24"
  description = "public subnet 1 CIDR Block"
  type = string 
}
#public-subnet-2
variable "public-subnet-2-cidr" {
  default = "10.0.1.0/24"
  description = "public subnet 2 CIDR Block"
  type = string 
}

#private-subnet-1
variable "private-subnet-1-cidr" {
  default = "10.0.2.0/24"
  description = "private subnet 1 CIDR Block"
  type = string 
}
#private-subnet-2
variable "private-subnet-2-cidr" {
  default = "10.0.3.0/24"
  description = "private subnet 2 CIDR Block"
  type = string 
}

#private-subnet-3
variable "private-subnet-3-cidr" {
  default = "10.0.4.0/24"
  description = "private subnet 4 CIDR Block"
  type = string 
}

#private-subnet-4
variable "private-subnet-4-cidr" {
  default = "10.0.5.0/24"
  description = "private subnet 5 CIDR Block"
  type = string 
}


#private-subnet-4
variable "ssh-location" {
  default = "0.0.0.0/0"
  description = "SSH IP address"
  type = string 
}