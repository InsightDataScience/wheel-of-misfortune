# wheel-of-misfortune

1. Install terraform

  * download zip from [here](https://www.terraform.io/downloads.html)
  * `$ unzip terraform_*.zip -d /usr/local/bin`

2. Update your `bash_profile`

  ```
  export TF_VAR_aws_access_key=${AWS_ACCESS_KEY_ID}
  export TF_VAR_aws_secret_key=${AWS_SECRET_ACCESS_KEY}
  export TF_VAR_aws_region=${AWS_DEFAULT_REGION}
  export TF_VAR_aws_key_path="~/.ssh/wom-us-east-1.pem"
  export TF_VAR_aws_key_name="wom"
  ```

3. You should be able to go into any misfortune foler and run the following:

  * `terraform plan` - shows what will be created (dry-run)
  * `terraform apply` - brings up infra
  * `terraform plan -destroy` - shows what will be taken down (dry-run)
  * `terraform destroy` - takes down infra
