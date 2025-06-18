variable "env" {
  description = "Please, choose between dev or prod environment."
  type        = string
  default     = "dev"

  validation {
    condition     = (var.env == "dev") || (var.env == "prod")
    error_message = "Must be \"dev\" or \"prod\" only."
  }
}