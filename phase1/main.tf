provider "helm" {
  kubernetes {
    config_path = var.kubeconfig-path
  }
}

provider "kubernetes" {
  config_path = var.kubeconfig-path
}

resource "helm_release" "minio" {
  repository = "https://charts.bitnami.com/bitnami"
  name       = "minio"
  chart      = "minio"

  set {
    name  = "ingress.enabled"
    value = "true"
  }
  set {
    name  = "ingress.hostname"
    value = var.minio-hostname
  }
  set {
    name  = "auth.rootUser"
    value = var.minio-root-user
  }
  set {
    name  = "auth.rootPassword"
    value = var.minio-root-password
  }
  
  set {
    name  = "apiIngress.enabled"
    value = "true"
  }
  
  set {
    name  = "apiIngress.hostname"
    value = var.minio-api-hostname
  }
  set {
    name  = "mode"
    value = "distributed"
  }
  set {
    name  = "defaultBucket.enabled"
    value = "true"
  }
  set {
    name  = "defaultBucket.versioning"
    value = "true"
  }
}