resource "yandex_compute_instance" "worker" {
    name        = "worker-${count.index + 1}"
    zone = var.node_zones[count.index]
  platform_id = "standard-v1"
  
  count = 2

  resources {
    cores  = 2
    memory = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2004-lts.image_id
      type = "network-hdd"
      size = 20
    }   
  }

    metadata = {
      user-data          = data.template_file.cloudinit.rendered
      serial-port-enable = 1
  }

  scheduling_policy { preemptible = true }

  network_interface {
    subnet_id = lookup(
      {
        "ru-central1-a" = yandex_vpc_subnet.public-a.id,
        "ru-central1-b" = yandex_vpc_subnet.public-b.id,
        "ru-central1-d" = yandex_vpc_subnet.public-d.id,
      },
      var.node_zones[count.index],
      null
    )
    nat       = true
  }
  allow_stopping_for_update = true
  
}