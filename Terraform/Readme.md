# Infrastructure as Code with Terraform: EC2 Backend Deployment

## 1. Architecture Explanation
This project demonstrates the use of **Terraform** to provision a fully automated and secure backend environment on **AWS**.

* **IaC Strategy**: Terraform is used to ensure the infrastructure is reproducible, modular, and easily maintainable.
* **Networking Layer**: 
    * Utilizes the **Default VPC** and **Default Subnets** for baseline connectivity.
    * A custom **Security Group** acts as a stateful firewall:
        * **SSH (Port 22)**: Restricted strictly to the administrator's public IP.
        * **HTTP (Port 80)**: Open for standard web access.
        * **App Port (3000)**: Open to expose the Node.js API service.
* **Compute Layer**: A single **t3.micro EC2 instance** running **Amazon Linux 2023**.
* **Automation**: The software stack is deployed via **EC2 User Data**, which handles the installation of Node.js and the startup of the API service without manual SSH intervention.


## 2.Terraform Deployment and Validation

This guide outlines the process of transitioning from Infrastructure as Code (IaC) to a fully functional verification environment.

Phase 1: Infrastructure Provisioning

Run the following command to build the environment:

terraform init
terraform apply

Terraform creates the EC2 instance and Security Groups.

Automatic Execution: The user_data script triggers immediately, installing Node.js and starting the backend API service automatically.

Phase 2: Environment Verification (Validation)

After deployment, perform manual verification.

Access: Open the browser and go to the output URL (http://3.236.229.213:3000).

Confirm:

Navigate to http://3.236.229.213:3000/ to see the welcome message.

Navigate to http://3.236.229.213:3000/info to verify that the student details are rendered correctly in JSON format.

Phase 3: Reproducibility Test

To satisfy the "Easily reproducible" requirement:

Run terraform destroy to tear down the environment.




## 3. Application Details
The backend service is a lightweight REST API built for cloud infrastructure validation.

* **Runtime**: Node.js
* **Framework**: Express.js
* **Endpoints**:
    * `GET /`: Returns a "Hello from Assignment 2" welcome message.
    * `GET /info`: Returns a JSON object containing the Student Name, Student ID, and Course Name.


## 4. Access and Port Information
* **Public IP**: The instance is assigned a dynamic Public IPv4 address by AWS.
* **Service Port**: The application listens on **Port 3000**.
* **Access URL**: `http://3.236.229.213:3000/info`

## 5. Cleanup and Reproducibility
To verify the reproducibility of the solution and avoid AWS costs, run:

terraform destroy -auto-approve

Screenshots:

1. Terraform apply success(CLI)

![terraform init](/Srceenshots/terraform_init.png)

![Terraform apply](/Srceenshots/Terraform_apply.png)

![Terraform apply](/Srceenshots/Terraform_apply2.png)


2. Running application Validation(browser)

![Validation](/Srceenshots/Validation.png)

EC2(instance type: t3.micro):

![EC2_instance](/Srceenshots/EC2_instance.png)


3. Terraform_destroy
![Terraform destroy](/Srceenshots/Terraform_destroy.png)
