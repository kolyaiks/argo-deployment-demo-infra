variable "region" {
  description = "Enter the AWS region."
  type        = string
  default     = "us-east-2"
}

variable "ec2_instance_type" {
  description = "Enter the instance type."
  default     = "t2.micro"
  type        = string
}

variable "ec2_instance_profile" {
  description = "Enter the instance profile name."
  type        = string
}

variable "security_groups_set" {
  description = "Enter the security groups set."
  type        = set(string)
}

variable "public_subnets_list" {
  description = "Enter the public subnets list where we can launch EC2 in."
  type        = list(string)
}

variable "ec2_instances_list" {
  description = "Enter the EC2 name list."
  type        = list(string)
  default = [
    "prod_primary",
    "prod_secondary",
    "dev_primary",
  "dev_secondary"]
}

variable "env" {
  description = "Please, choose between dev or prod environment."
  type        = string
  default     = "dev"

  validation {
    condition     = (var.env == "dev") || (var.env == "prod")
    error_message = "Must be \"dev\" or \"prod\" only."
  }
}

variable "name_of_application" {
  description = "Enter the name of application to deploy on EC2."
  type        = string
}

variable "bucket_name" {
  description = "Enter the name of bucket with configuration files for application."
  type        = string
}

variable "key_name" {
  description = "Please, enter the ssh key name."
  type        = string
  default     = "production"
}
