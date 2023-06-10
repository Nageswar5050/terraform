terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~>4.0"
        }
    }
}

provider "aws" {
    region = "${var.region["region_1"]}"
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
}