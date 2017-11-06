/**
 * AWS VPN Terraform Module
 * =====================
 *
 * Usage:
 * ------
 *
 *     module "vpn" {
 *       source      = "../tf_vpn"
 *
 *       add variables
 *     }
**/

resource "aws_vpn_connection" "vpn" {
  vpn_gateway_id      = "${var.vpn_gateway_id}"
  customer_gateway_id = "${var.customer_gateway_id}"
  type                = "ipsec.1"
  static_routes_only  = true
  lifecycle {
    prevent_destroy = true
  }
  tags = "${ merge(
    var.tags,
    map("Name", var.namespaced ?
     format("%s-%s-vpn", var.environment, var.name) :
     format("%s-vpn", var.name) ),
    map("Environment", var.environment),
    map("Terraform", "true") )}"
}

resource "aws_vpn_connection_route" "vpn_route" {
  count                   = "${length(var.cidrs)}"
  destination_cidr_block  = "${element(var.cidrs, count.index)}"
  vpn_connection_id       = "${aws_vpn_connection.vpn.id}"
}
