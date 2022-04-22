terraform {
  required_providers {
    minio = {
      source = "aminueza/minio"
      version = "1.5.1"
    }
  }
}

provider minio {
  minio_server       = data.terraform_remote_state.phase1.outputs.minio-api-hostname
  minio_access_key   = data.terraform_remote_state.phase1.outputs.minio-root-user
  minio_secret_key   = data.terraform_remote_state.phase1.outputs.minio-root-password
}

data "terraform_remote_state" "phase1" {
  backend = "local"

  config = {
    path = "../phase1/terraform.tfstate"
  }
}

resource "minio_s3_bucket" "minio-config" {
  bucket = var.bucket-name
  acl    = "public"
}



