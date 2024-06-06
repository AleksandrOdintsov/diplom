# Создание сети 
resource "yandex_vpc_network" "vps" {
  name = var.vpc_name
}
# Создание публичной подсети  в зоне а
resource "yandex_vpc_subnet" "public-a" {
  name           = "public-a"
  zone           = var.zone_a
  network_id     = yandex_vpc_network.vps.id
  v4_cidr_blocks = var.default_cidr_a
}
# Создание публичной подсети  в зоне b
resource "yandex_vpc_subnet" "public-b" {
  name           = "public-b"
  zone           = var.zone_b
  network_id     = yandex_vpc_network.vps.id
  v4_cidr_blocks = var.default_cidr_b
}
# Создание публичной подсети  в зоне d
resource "yandex_vpc_subnet" "public-d" {
  name           = "public-d"
  zone           = var.zone_d
  network_id     = yandex_vpc_network.vps.id
  v4_cidr_blocks = var.default_cidr_d
}


