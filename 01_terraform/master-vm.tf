
resource "yandex_compute_instance" "master" {
    name        = "master-${count.index + 1}"
    zone        =  var.zone_d
  platform_id = "standard-v2"
  
  count = 1

  resources {
    cores  = 4
    memory = 4
    core_fraction = 20
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2004-lts.image_id
      size = 20
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.public-d.id
    nat       = true
  }
  
  depends_on = [yandex_compute_instance.worker]
  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = 1
  }

}
