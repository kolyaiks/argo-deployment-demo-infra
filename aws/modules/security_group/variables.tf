variable "sg_name" {
  description = "Please, enter the SG name."
}

variable "vpc_id" {
  description = "Please, enter the VPC id."
}

variable "ingress_ports_set" {
  description = "Please, enter the port to allow traffic from."
  type        = set(string)
}

variable "ingress_cidr_set" {
  description = "Please, enter the ingress CIDR list."
  type        = set(string)
  default = [
  "0.0.0.0/0"]
}

variable "egress_ports_set" {
  description = "Please, enter the port to allow traffic to."
  type        = set(string)
  default = [
  "0"]
}

variable "egress_cidr_set" {
  description = "Please, enter the engress CIDR list."
  type        = set(string)
  default = [
  "0.0.0.0/0"]
}

variable "tags" {
  default = "Please, enter tags."
}

