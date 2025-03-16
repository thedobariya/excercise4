variable "region" {
  description = "The region in which the resources will be created"
  default     = "us-east-1"
}

variable "zone1" {
  default = "us-east-1a"
}

variable "amiID" {
  type = map(any)
  default = {
    us-east-1 = "ami-08b5b3a93ed654d19"
    us-east-2 = "ami-0d0f28110d16ee7d6"
  }
}

variable "webuser" {
  default = "ubuntu"
}