# Terraform Autoscaling Web Service

This project builds a highly available, autoscaling web service on AWS using Terraform, deploying a basic Apache-based application behind an Application Load Balancer (ALB) and managed by an Auto Scaling Group (ASG).

## Project Overview

This project is split into two parts:

- Part I: Provisioning AWS infrastructure — VPC, public/private subnets, NAT/Internet Gateways, route tables.
- Part II: Deploying the application — ALB, EC2 launch templates, ASG, and CloudWatch alarms for dynamic scaling.

## Architecture Diagram

                    ┌────────────┐
                    │   Users    │
                    └────┬───────┘
                         │
                    ┌────▼─────┐
                    │   ALB    │
                    └────┬─────┘
                         │
          ┌──────────────┼──────────────┐
          │              │              │
    ┌─────▼────┐   ┌─────▼────┐   ┌─────▼────┐
    │  EC2 1   │   │  EC2 2   │   │  EC2 3   │ (Auto Scaling)
    └──────────┘   └──────────┘   └──────────┘
          ▲              ▲              ▲
          └──────Private Subnets────────┘
                    (3 AZs)

          + NAT Gateway for outbound access
          + CloudWatch alarms for CPU-based scaling

## Technologies Used

| Tool             | Purpose                              |
|------------------|--------------------------------------|
| Terraform        | Infrastructure provisioning (IaC)    |
| AWS              | Cloud provider                       |
| Apache HTTPD     | Simple web app (EC2 user data)       |
| CloudWatch       | Metrics & autoscaling alarms         |
| GitHub Actions   | CI/CD (optional in future phase)     |

## File Structure

```bash
.
├── main.tf                      # Entry point
├── vpc.tf                       # VPC, subnets, gateways
├── alb.tf                       # ALB, listener, target group
├── launch_template.tf          # Launch template & EC2 SG
├── asg.tf                       # Auto Scaling Group & alarms
├── variables.tf                 # Input variables
├── scripts/
│   └── install_apache.sh        # EC2 user-data script
├── outputs.tf                   # Outputs (optional)
└── README.md                    # Documentation

Getting Started
Prerequisites
Terraform >= 1.5

AWS CLI configured (aws configure)

IAM user with sufficient permissions (EC2, ALB, Auto Scaling, etc.)

Getting Started
Prerequisites
Terraform >= 1.5

AWS CLI configured (aws configure)

IAM user with sufficient permissions (EC2, ALB, Auto Scaling, etc.)

Step 1: Clone the Repo
git clone https://github.com/your-username/terraform-autoscaling-webservice.git
cd terraform-autoscaling-webservice

Step 2: Initialize Terraform
terraform init

terraform plan
terraform apply -auto-approve

Note: This provisions real AWS infrastructure and may incur charges. Run terraform destroy when done.

| Component                 | Description                                        |
| ------------------------- | -------------------------------------------------- |
| VPC                       | Custom VPC with CIDR and 3 AZs                     |
| Public Subnets            | For ALB and NAT Gateways                           |
| Private Subnets           | For EC2 instances managed by ASG                   |
| Internet Gateway          | For public subnet outbound access                  |
| NAT Gateway               | Allows private subnet instances to access internet |
| Application Load Balancer | Exposes HTTP port 80 publicly                      |
| Target Group & Listener   | Health checks + routing config                     |
| EC2 Launch Template       | Installs Apache and displays hostname              |
| Auto Scaling Group        | Starts with 2 instances, scales between 2-5        |
| CloudWatch Alarms         | CPU-based scale-up policies                        |

Monitoring & Autoscaling
CloudWatch Metric Alarm monitors CPUUtilization

Auto Scaling Policy adds 1 instance if CPU > 60% over 2 intervals

You can extend this to include scale-down policies or integrate Prometheus/Grafana.

Apache Test Page
After deployment, navigate to the ALB DNS name (from Terraform output or AWS Console). You should see a page like:

This instance is: ip-10-0-1-123.ec2.internal

This confirms that the Apache server was successfully installed and is running.

Clean Up
terraform destroy


