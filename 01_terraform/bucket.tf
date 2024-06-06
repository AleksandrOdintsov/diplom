
# Создаем бакет 
resource "yandex_storage_bucket" "backend-odintsov" {
  access_key    = yandex_iam_service_account_static_access_key.srvac-static-key.access_key
  secret_key    = yandex_iam_service_account_static_access_key.srvac-static-key.secret_key
  bucket        = "backend-odintsov"
  acl           = "public-read"
  force_destroy = "true"
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.key-a.id
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

# # Создаем обьект в корзине
# resource "yandex_storage_object" "image-object" {
#   access_key    = yandex_iam_service_account_static_access_key.srvac-static-key.access_key
#   secret_key    = yandex_iam_service_account_static_access_key.srvac-static-key.secret_key
#   bucket        = "odinsov160524"
#   acl           = "public-read"
#   key           = "test.jpeg"
#   source        = "~/devops-netology/Cloud/15.2/scr/test.jpeg"
#   depends_on    = [yandex_storage_bucket.odinsov160524]
# }

# Шифруем бакет 