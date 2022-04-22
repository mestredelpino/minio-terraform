terraform {
  required_providers {
    minio = {
      source = "aminueza/minio"
      version = "1.5.1"
    }
  }
}

data "terraform_remote_state" "phase1" {
  backend = "local"

  config = {
    path = "../phase1/terraform.tfstate"
  }
}

data "terraform_remote_state" "phase2" {
  backend = "local"

  config = {
    path = "../phase2/terraform.tfstate"
  }
}

provider minio {
  minio_server       = data.terraform_remote_state.phase1.outputs.minio-api-hostname
  minio_access_key   = data.terraform_remote_state.phase1.outputs.minio-root-user
  minio_secret_key   = data.terraform_remote_state.phase1.outputs.minio-root-password
}

locals {
  minio-bucket = data.terraform_remote_state.phase2.outputs.minio-config-bucket
  folders = [for i in var.folder-paths : fileset(path.module, "${i}*")]
  files = flatten(local.folders)
}

data "local_file" "files" {
  for_each = toset(local.files)
  filename = each.key
}

resource "minio_s3_object" "folders" {
  for_each = data.local_file.files
  depends_on = [local.minio-bucket]
  bucket_name = local.minio-bucket.bucket
  object_name = trimprefix(each.key, "../")
  content = each.value.content_base64
}
