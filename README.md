# AWS Network Foundation with Terraform

A Terraform implementation of a two-AZ AWS network foundation. It separates public-facing infrastructure from private application subnets and enables VPC Flow Logs for network visibility.

## What this builds

- One VPC with DNS support and DNS hostnames enabled
- Two public subnets and two private subnets in separate Availability Zones
- Internet Gateway and public routing
- Optional NAT Gateway for private subnet outbound access
- CloudWatch Log Group and IAM role for VPC Flow Logs
- Resource tags and configurable CIDR ranges

## Architecture

```text
                         Internet
                            |
                     Internet Gateway
                            |
                +-----------+-----------+
                |                       |
          Public subnet A         Public subnet B
             (AZ A)                  (AZ B)
                |
            NAT Gateway
                |
          Private route table
                |
          +-----+------------------+
          |                        |
    Private subnet A         Private subnet B
    (application)            (application)

VPC Flow Logs ----------------> CloudWatch Logs
```

The diagram is a logical view of the resources. Availability Zone names are selected dynamically from the chosen AWS region.

## Repository layout

```text
.
├── .github/workflows/terraform.yml
├── main.tf
├── variables.tf
├── outputs.tf
├── versions.tf
├── terraform.tfvars.example
└── README.md
```

## Prerequisites

- Terraform 1.6 or newer
- AWS CLI configured for a sandbox AWS account
- AWS credentials with permissions to create VPC, subnet, route, NAT Gateway, Elastic IP, IAM and CloudWatch Logs resources

## Deploy

```bash
cp terraform.tfvars.example terraform.tfvars
# Edit values in terraform.tfvars for your environment.

terraform fmt -recursive
terraform init
terraform validate
terraform plan -out=tfplan
terraform apply tfplan
```

Review the plan before applying it. Do not run this against a production account without a change review and approval.

## Cost and design decisions

- The example uses one NAT Gateway to keep the lab's baseline cost lower. This means private subnet egress depends on a single Availability Zone.
- For a highly available production design, create one NAT Gateway per AZ and route each private subnet through its local NAT Gateway.
- NAT Gateway hourly and data-processing charges apply.
- CloudWatch Logs ingestion and retention charges apply.
- Set `enable_nat_gateway = false` when you only need to validate the network layout and do not need private subnet internet egress.

## Validate

The GitHub Actions workflow runs formatting and Terraform validation on pushes and pull requests. It does not authenticate to AWS or deploy infrastructure.

Local checks:

```bash
terraform fmt -check -recursive
terraform init -backend=false
terraform validate
```

## Cleanup

```bash
terraform destroy
```

Inspect the destroy plan and confirm the target workspace/account before cleanup.

## Project status

Infrastructure code and CI validation workflow are provided. A successful AWS deployment is not claimed by this repository; deployment should be performed and verified in your own sandbox account.
