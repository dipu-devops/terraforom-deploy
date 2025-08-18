output "vnet_id" {
  value = azurerm_virtual_network.main.id
}

output "subnet_ids" {
  value = {
    for k, s in azurerm_subnet.subnets : k => s.id
  }
}

output "private_dns_zone_ids" {
  value = {
    for key, zone in azurerm_private_dns_zone.dns_zones : 
    zone.name => zone.id
  }
}