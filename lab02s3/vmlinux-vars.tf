variable "linux_name" {
  type = string
  default = "n01580452-u-vm1"
}
variable "size" {
  type = string
  default = "Standard_B1s"
}
variable "admin_username" {
  type = string
  default = "firstN01580452"
}
variable "public_key" {
  type = string
  default = "/Users/babanjot/.ssh/id_rsa.pub"
}
variable "os_disk" {
  type = list(object({
    storage_account_type = string
    disk_size = number
    caching = string
  }))
  default = [
    {
      storage_account_type = "Premium_LRS"
      disk_size = 32
      caching = "ReadWrite"
    }
  ]
}
variable "os_info" {
  type = list(object({
    publisher = string
    offer = string
    sku = string
    version = string
  }))
  default = [
    {
      publisher = "canonical"
      offer = "0001-com-ubuntu-server-focal"
      sku = "20_04-lts-gen2"
      version = "latest"
    }
  ]
}