# Создаем сервисный аккаунт 
resource "yandex_iam_service_account" "srvac" {
  name = "srvac"
  description = "service account for bucket"
}
# Назначаем роли сервисному аккаунту для управления ресурсами и сетями
resource "yandex_resourcemanager_folder_iam_member" "srvac-editor" {
  folder_id = var.folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.srvac.id}"
}
# Назначаем роли сервисному аккаунту  для работы с S3-бакетами
resource "yandex_resourcemanager_folder_iam_member" "srvac-s3" {
  folder_id = var.folder_id
  role      = "storage.admin"
  member    = "serviceAccount:${yandex_iam_service_account.srvac.id}"
}
# Назначаем роли сервисному аккаунту  для работы с ключами
# resource "yandex_iam_service_account_iam_binding" "srvac_key_manager" {
#   role               = "iam.serviceAccountKeyAdmin"
#   members   = "serviceAccount:${yandex_iam_service_account.srvac.id}"
# }

# Создаем статический ключ доступа
resource "yandex_iam_service_account_static_access_key" "srvac-static-key" {
  service_account_id = yandex_iam_service_account.srvac.id
  description        = "static access key for object storage"
}

# # Создаем сервисный аккаунт для работы Instance Group 
# resource "yandex_iam_service_account" "srvac-ig" {
#   name = "srvac-ig"
# }

# # Назначение роли сервисному аккаунту для работы с Instance Group 
# resource "yandex_resourcemanager_folder_iam_member" "srvac-ig-editor" {
#   folder_id = var.folder_id
#   role      = "editor"
#   member    = "serviceAccount:${yandex_iam_service_account.srvac-ig.id}"
# }

# Создание симметричного ключа Yandex KMS

resource "yandex_kms_symmetric_key" "key-a" {
  name              = "KMS Key"
  description       = "KMS for YC backet"
  default_algorithm = "AES_128"
  rotation_period   = "8760h" // equal to 1 year
  lifecycle {
    prevent_destroy = false
  }
}