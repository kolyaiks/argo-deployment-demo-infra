variable "eips_map" {
  description = "Enter the map of eips."
  type        = map(string)
  default = {
    prod_primary   = "3.131.239.181"
    prod_secondary = "3.16.182.216"
  }
}