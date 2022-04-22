variable "minio-hostname" {
    description = "The hostname for your MinIO deployment (UI access)"
}

variable "minio-api-hostname" {
    description = "The hostname for your MinIO deployment (API access)"
}

variable "minio-root-user" {
    description = "The root's user name"
}

variable "minio-root-password" {
    description = "The root user's password"
}

variable "kubeconfig-path" {
    description = "The full path of the Kubernetes config file where MinIO will be deployed"
  
}
