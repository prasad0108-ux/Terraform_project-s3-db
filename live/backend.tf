terraform {
  backend "s3" {
    bucket         = "terraform-demo-ccprasad"
    key            = "env/dev/terraform.tfstate"
    region         = "us-east-1"                  # <- specify your region
    dynamodb_table = "terraform-lock-table"
  }
}
