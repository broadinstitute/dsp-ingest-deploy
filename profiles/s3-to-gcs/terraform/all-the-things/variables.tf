locals {
  broad_range_cidrs = [
    "69.173.64.0/19",
    "69.173.96.0/20",
    "69.173.112.0/21",
    "69.173.120.0/22",
    "69.173.124.0/23",
    "69.173.126.0/24",
    "69.173.127.0/25",
    "69.173.127.128/26",
    "69.173.127.192/27",
    "69.173.127.224/30",
    "69.173.127.228/32",
    "69.173.127.230/31",
    "69.173.127.232/29",
    "69.173.127.240/28"
  ]
  k8s_master_private_ipv4_cidr = "10.0.82.0/28"
  broad_routeable_net = "69.173.64.0/18"
}

variable "env" {
  type = string
}

variable "app_name" {
  type = string
}

variable "google_project" {
  type = string
}

variable "core_google_project" {
  type = string
}

variable "google_region" {
  type = string
}

variable "dns_zone" {
  type = string
}

variable "dns_zone_name" {
  type = string
}

variable "ingest_project" {
  type = string
}

variable "k8s_cluster_name" {
  type = string
}

variable "k8s_version" {
  type = string
}

variable "k8s_node_count" {
  type = number
}

variable "k8s_machine_type" {
  type = string
}
