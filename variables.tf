variable "google_project" {
  type = string
  default = "gd-gcp-internship-devops"
}

variable "service_account_email" {
  type = string
  default = "71936227901-compute@developer.gserviceaccount.com"
}

variable "google_region" {
  type = string
  default = "europe-west1"
}

variable "google_zone" {
  type = string
  default = "europe-west1-b"
}

variable "app_network_name" {
  type = string
  default = "app-network"
}

variable "app_subnet_name" {
  type = string
  default = "app-subnet"
}

variable "app_max_replicas" {
  type = number
  default = 1
}

variable "app_min_replicas" {
  type = number
  default = 1
}
