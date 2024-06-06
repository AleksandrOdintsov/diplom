resource "local_file" "hosts_cfg" {
 content = templatefile("${path.module}/hosts.tftpl",
    {
 workers = yandex_compute_instance.worker
 masters = yandex_compute_instance.master
    }
  )
 filename = "/Users/aleksandrodincov/devops-netology/diplom/02_k8s/hosts.yaml"
}