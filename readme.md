# Project Setup Documentation

This documentation provides step-by-step instructions on how to install Terraform, set up AWS credentials, and run the project.

## Prerequisites

Before you begin, make sure you have the following prerequisites:

- Operating System: Windows, macOS, or Linux
- An AWS account with appropriate permissions to create resources.
- Basic knowledge of AWS services, Terraform, and Ansible.

## Installation Steps

### 1. Install Terraform

Follow these steps to install Terraform:

1. Visit the official Terraform website at [https://www.terraform.io/](https://www.terraform.io/).

2. Download the appropriate Terraform binary for your operating system.

3. Extract the downloaded archive.

4. Add the Terraform binary location to your system's PATH variable.

5. Open a terminal or command prompt and verify the installation by running the following command:

```shell
terraform version
```
### 2. Set Up AWS Credentials

To interact with AWS services locally, you can set up AWS credentials in your environment using access keys. Follow these steps:

1. Sign in to the AWS Management Console using your AWS account credentials.

2. Open the IAM service.

3. Create a new IAM user or use an existing one. Ensure that the user has appropriate permissions to create resources such as EC2 instances, security groups, etc.

4. Generate an access key for the IAM user and make note of the Access Key ID and Secret Access Key.

### 3. Configure AWS Credentials Locally

To configure AWS credentials locally, you need to set the following environment variables:

- `AWS_ACCESS_KEY_ID`: The Access Key ID for your IAM user.
- `AWS_SECRET_ACCESS_KEY`: The Secret Access Key for your IAM user.
Set these environment variables using the appropriate method for your operating system:

- **Linux/macOS**:

  Open a terminal and run the following commands, replacing `<access_key_id>` and `<secret_access_key>` with your actual values:

  ```shell
  export AWS_ACCESS_KEY_ID=<access_key_id>
  export AWS_SECRET_ACCESS_KEY=<secret_access_key>
  ```

### 4. Update AWS Region (Optional)
If you wish to deploy the resources in a different AWS region, you can update the region in the main.tf file.

Open the main.tf file located in the project directory and modify the following line:
```hcl
provider "aws" {
  region = "eu-central-1"
}
```

Replace `eu-central-1` with your desired AWS region code (e.g., `us-west-2`).

## 5. Set Up Ansible
To set up Ansible, follow these steps:

1. Install Ansible on your local machine. You can refer to the Ansible documentation for detailed installation instructions based on your operating system.

2. Create an ansible.cfg file in the ansible directory of the project repository.

3. Add the following content to the ansible.cfg file:

```ini
[defaults]
host_key_checking = False
```
- This configuration will disable host key checking for Ansible.

4. Create two Ansible playbook files within the ansible directory:

`playbook_client.yml:` This playbook will configure the client instance.
Populate the playbooks with the necessary tasks and roles according to your requirements. Here's an example of the playbook structure:

```yaml
- name: Configure the client instance
  become: yes
  hosts: tag_Name_client
  user: ubuntu
  roles:
    - node-exporter
    - docker
    - my_sql
      - wordpress
 ```
`playbook_server.yml:` This playbook will configure the server instance.
  ```yaml
  - name: Configure the server instance
    become: yes
    hosts: tag_Name_server
    user: ubuntu
    roles:
      - prometheus
      - grafana
  ```
6.Customize the roles and tasks as needed for your application.



### 6. Run the Terraform Commands
Navigate to the project directory in the terminal or command prompt:

```shell
cd <project_directory>
```
Execute the following Terraform commands in order:

1. Initialize the Terraform working directory:

```shell
terraform init
```
2. Plan the infrastructure changes to be applied:

```shell
terraform plan
```
Review the planned changes and ensure they match your expectations.

3. Apply the infrastructure changes:

```shell
terraform apply
```
Confirm the changes by typing `yes` when prompted.

Terraform will provision the necessary AWS resources, including the EC2 instances and security group.

4. Wait for the deployment to complete. It may take a few minutes to provision the resources.

### 7. Verify Deployment
After the deployment is complete, you can verify the successful creation of resources:

1. Check the Terraform outputs:

```shell
terraform output
```
It will display the public IP addresses of the created EC2 instances (`client_ip` and `server_ip`).

2. SSH into the client and server instances using the private key



## Next steps: 

- Encrypt all passwords by ansible-vault
- Setup Nginx and setup certificates for https connection
- Create default dashboards for grafana
- Resolve problem with connection to local mySql from docker
- Deploy the terraform main.tf from AWS CLI to prevent open 22 to worldwide 
- Secure all ports inside the cluster ( allow only necessary connections)
- imporve settings for prometheus and grafana
- 
