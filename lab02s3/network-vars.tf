variable "resource_group_name" {
  type = string
  default = "network-rg"
}
variable "location" {
  type = string
  default = "Central India"
}
variable "vNet_name" {
  type = string
  default = "network-vnet"
}
variable "vnet_address_space" {
  type = string
  default = "10.0.0.0/16"
}
variable "subnet_1" {
  type = string
  default = "network-subnet1"
}
variable "subnet_2" {
  type = string
  default = "network-subnet2"
}
variable "address_subnet_1" {
  type = string
  default = "10.0.0.0/24"
}
variable "address_subnet_2" {
  type = string
  default = "10.0.1.0/24"

}
variable "network_security_group_1" {
  type = string
  default = "network-nsg1"
}
variable "network_security_group_2" {
  type = string
  default = "network-nsg2"

}