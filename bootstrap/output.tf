cd terraform-aws-project/bootstrap

# initialize and create the backend resources
terraform init
terraform apply -var="state_bucket_name=your-unique-tfstate-bucket-12345" -auto-approve
