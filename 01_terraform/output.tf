output "masters_public_ips" {
  description = "Public IP addresses for master-nodes"
  value = yandex_compute_instance.master.*.network_interface.0.nat_ip_address
}

output "masters_private_ips" {
  description = "Private IP addresses for master-nodes"
  value = yandex_compute_instance.master.*.network_interface.0.ip_address
}
