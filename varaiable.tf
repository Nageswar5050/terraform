variable "region" {
  type = map(any)
  default = {
    region_1 = "ap-south-1"
    region_2 = "ap-south-2"
  }
}

variable "access_key" {
  type    = string
  default = ""
}

variable "secret_key" {
  type    = string
  default = ""
}

variable "az_1" {
  type    = list(any)
  default = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
}

variable "az_2" {
  type    = list(any)
  default = ["ap-south-2a", "ap-south-2b", "ap-south-2c"]
}

variable "name" {
  type    = string
  default = "Prod"
}
