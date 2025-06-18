variable "region" {
  description = "Enter the AWS region."
  default     = "us-east-1"
}

variable "company_name" {
  description = "Enter the company name."
  default     = "kolyaiks"
}

variable "hosted_zone_name" {
  description = "Enter the hosted zone name."
  default     = "test.com"
}

variable "cluster_endpoint_public_access" {
  description = "If EKS cluster API endpoint should be public"
  type        = bool
  default     = false
}

variable "cluster_endpoint_public_access_cidrs" {
  description = "List of ranges that's allowed to work with EKS cluster API endpoint"
  type        = list(string)
}

variable "domain_names" {
  description = "Domain names to use while creating R53 entries"
  type        = list(string)
}