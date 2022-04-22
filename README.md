# Minio Bootstrap

This terraform scripts allow you to deploy MinIO on Kubernetes with Helm. Additionally, you can create a bucket and upload
any folder you want to it.

## Deploying MinIO

1. Clone the repo

```
git clone https://github.com/mestredelpino/minio-terraform.git
```

2. Create a file "phase1/terraform.tfvars" and paste these variables to deploy MinIO on Kubernetes.
```
minio-hostname      = "" # The hostname for your MinIO deployment (example.domain.com)
minio-api-hostname  = "" # The hostname for the API of your MinIO deployment (example-api.domain.com)
minio-root-user     = "" # The root user
minio-root-password = "" # The password for the root user
kubeconfig-path     = "" # The path to the Kubernetes config file (where MinIO will get deployed)
```

3. On a console, on the phase 1 folder, run:
```
terraform init
terraform apply
```
## Creating a bucket

1. Create a file "phase2/terraform.tfvars" and paste these variables to create an s3 bucket.
```
bucket-name = "" # The name you want to give to your s3 bucket
```

2. Navigate to phase2 and run:
```
terraform init
terraform apply
```

## Uploading a folder

1. Create a file "upload_folders/terraform.tfvars" and paste these variables to create an s3 bucket.
```
folder-paths = ["",""] # List with the absolute (or relative) paths to the directories you want to upload
```

For example, you might want to upload the content of the phase1 and phase2 folders, in that case the you will write the variable
as such:

```
folder-paths = ["../phase1/","../phase2/"] 
```

2. Navigate to the upload_folders directory and run:
```
terraform init
terraform apply
```


And that's it! You created a MinIO deployment with a bucket and uploaded a few files into it!

