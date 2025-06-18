/* Output will be like:
eips = {
  "prod_primary" = "3.23.2.113"
  "prod_secondary" = "3.12.175.1"
}
*/

//because aws_eip.eips produces the map, we have to iterate this map with two parameters
output "eips" {
  value = {
    for key, value in aws_eip.eips :
    key => value.public_ip
  }
}