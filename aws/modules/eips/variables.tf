variable "ec2s" {
  description = "Enter the map of EC2 names and ids."
  type        = map(string)
  default = {
    prod_primary   = "i-08639c56ce5d8a536"
    prod_secondary = "i-06ff78277d368035d"
  }
}