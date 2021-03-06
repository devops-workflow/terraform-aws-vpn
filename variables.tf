
// Standard Variables

variable "name" {
  description = "Name"
}
variable "environment" {
  description = "Environment (ex: dev, qa, stage, prod)"
}
variable "namespaced" {
  description = "Namespace all resources (prefixed with the environment)?"
  default     = true
}
variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
}

// Module specific Variables

variable "cidrs" {
  description = "CIDRS"
  type        = "list"
}
variable "customer_gateway_id" {
  description = "Customer Gateway ID"
}
variable "vpn_gateway_id" {
  description = "VPN Gateway ID"
}
