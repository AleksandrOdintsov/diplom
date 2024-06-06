###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "zone_a" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "zone_b" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "zone_d" {
  type        = string
  default     = "ru-central1-d"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr_a" {
  type        = list(string)
  default     = ["192.168.10.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}
variable "default_cidr_b" {
  type        = list(string)
  default     = ["192.168.20.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}
variable "default_cidr_d" {
  type        = list(string)
  default     = ["192.168.30.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "vpc"
  description = "VPC network&subnet name"
}

variable "public_key" {
type = object({
  ssh-keys           = string
})
default = {
    ssh-keys            = null
}
description = "Instance envs"
}

variable "image_id" {
  type        = string
  default     = "https://storage.yandexcloud.net/odinsov160524/test.jpeg"
}

variable "vm_yandex_compute_instance_standart" {
  type        = string
  default     = "standard-v1"
  description = "Instance envs"
}

variable "node_zones" {
  default = ["ru-central1-a", "ru-central1-b", "ru-central1-d"]
}
