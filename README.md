# wheel-of-misfortune

1. Install Terraform

  * download zip from [here](https://www.terraform.io/downloads.html)
  * `$ unzip terraform_*.zip -d /usr/local/bin`

2. Update your `bash_profile`

  ```
  export TF_VAR_aws_access_key=${AWS_ACCESS_KEY_ID}
  export TF_VAR_aws_secret_key=${AWS_SECRET_ACCESS_KEY}
  export TF_VAR_aws_region=${AWS_DEFAULT_REGION}
  export TF_VAR_aws_key_path="~/.ssh/wom-us-west-2.pem"
  export TF_VAR_aws_key_name="wom"
  ```

3. You should be able to go into any misfortune folder and run the following:

  * `terraform plan` - shows what will be created (dry-run)
  * `terraform apply` - brings up infra
  * `terraform plan -destroy` - shows what will be taken down (dry-run)
  * `terraform destroy` - takes down infra

4. Install Ansible

  * `$ sudo pip install ansible`
  
5. Set your Ansible default configuration in `/etc/ansible/ansible.cfg`

  ```
  [defaults]
  host_key_checking = False
  remote_user = ubuntu
  ```
  
6. Download the ec2.ini into `/etc/ansible`

  * `$ sudo wget https://raw.githubusercontent.com/ansible/ansible/devel/contrib/inventory/ec2.ini -P /etc/ansible`
  
7. Download the ec2.py into `/etc/ansible` and make it executable

  * `$ sudo wget https://raw.githubusercontent.com/ansible/ansible/devel/contrib/inventory/ec2.py -P /etc/ansible`
  * `$ sudo chmod +x /etc/ansible/ec2.py`
