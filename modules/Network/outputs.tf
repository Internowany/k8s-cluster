output "Subnet_IDs" {
  description = "Subnet_IDs"
  value       = ["${aws_subnet.SK_subnets["a"].id}", "${aws_subnet.SK_subnets["b"].id}", "${aws_subnet.SK_subnets["c"].id}"]
}
output "control_Subnet_IDs" {
  description = "control_Subnet_IDs"
  value       = ["${aws_subnet.SK_subnets["d"].id}", "${aws_subnet.SK_subnets["e"].id}", "${aws_subnet.SK_subnets["f"].id}"]
}
output "SEC_GROUP_ID" {
  description = "SEC_GROUP_ID"
  value       = aws_security_group.SK_sg.id
}
output "VPC_ID" {
  description = "VPC_ID"
  value       = aws_vpc.SK_vpc.id
}
