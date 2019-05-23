variable "broad_range_cidrs" {
  default = [
  {
    cidr_block = "69.173.64.0/19"
  },
  {
    cidr_block = "69.173.96.0/20"
  },
  {
    cidr_block = "69.173.112.0/21"
  },
  {
    cidr_block = "69.173.120.0/22"
  },
  {
    cidr_block = "69.173.124.0/23"
  },
  {
    cidr_block = "69.173.126.0/24"
  },
  {
    cidr_block = "69.173.127.0/25"
  },
  {
    cidr_block = "69.173.127.128/26"
  },
  {
    cidr_block = "69.173.127.192/27"
  },
  {
    cidr_block = "69.173.127.224/30"
  },
  {
    cidr_block = "69.173.127.228/32"
  },
  {
    cidr_block = "69.173.127.230/31"
  },
  {
    cidr_block = "69.173.127.232/29"
  },
  {
    cidr_block = "69.173.127.240/28"
  }
  ]
}

# CIDR to use for the hosted master netwok. must be a /28 that does NOT overlap with the network k8s is on
variable "k8s_masters_ipv4_cidr" {
  type = "string"
  default = "10.128.1.0/28"

}

variable "k8s_masters_private_ipv4_cidr" {
  type    = "string"
  default = "10.0.82.0/28"
}

variable "broad_routeable_net" {
   default = "69.173.64.0/18"
   description = "Broad's externally routable IP network"
}
