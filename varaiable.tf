variable "region" {
    type = map
    default = {
        region_1 = "ap-south-1"
        region_2 = "ap-south-2"
    }
}

variable "access_key" {
    type = string
    default = "AKIATHTLCWI2J2EYOTKG"
}

variable "secret_key" {
    type = string
    default = "yY+H5CErvPklTyIea61uEVWwdusVyno81gqE3kiA"
}