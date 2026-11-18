variable "aws_region" {
  description = "AWS region where the network will be created."
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Short identifier used in resource names."
  type        = string
  default     = "network-foundation"
}

variable "environment" {
  description = "Environment name such as dev, test or prod."
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "IPv4 CIDR range for the VPC."
  type        = string
  default     = "10.20.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR ranges for the two public subnets."
  type        = list(string)
  default     = ["10.20.1.0/24", "10.20.2.0/24"]

  validation {
    condition     = length(var.public_subnet_cidrs) == 2
    error_message = "Provide exactly two public subnet CIDRs."
  }
}

variable "private_subnet_cidrs" {
  description = "CIDR ranges for the two private subnets."
  type        = list(string)
  default     = ["10.20.11.0/24", "10.20.12.0/24"]

  validation {
    condition     = length(var.private_subnet_cidrs) == 2
    error_message = "Provide exactly two private subnet CIDRs."
  }
}

variable "flow_log_retention_days" {
  description = "CloudWatch Logs retention in days."
  type        = number
  default     = 30
}

variable "enable_nat_gateway" {
  description = "Whether to create a NAT Gateway and private default route."
  type        = bool
  default     = true
}
