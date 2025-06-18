/* Output ec2s will be like map below:
ec2s = {
  "prod_secondary" = "i-01f568bc7f0c8037b"
  "prod_primary" = "i-08639c56ce5d8a536"
}
*/

output "ec2s" {
  value = {
    for instance in aws_instance.ec2s :
    lookup(instance.tags, "Name") => instance.id
  }
}