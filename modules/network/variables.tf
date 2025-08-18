variable "name" {
  description = "Base name for network"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "prefix" {
  description = "Naming prefix"
  type        = string
  default     = "ais"
}

variable "address_space" {
  description = "VNet address space"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnets" {
  description = "Subnet configuration"
  type = map(object({
    cidr                   = string
    service_endpoints      = list(string)
    private_endpoint_enabled = bool
  }))
  default = {
    ingress = {
      cidr                   = "10.0.1.0/24"
      service_endpoints      = ["Microsoft.Storage"]
      private_endpoint_enabled = true
    }
    process = {
      cidr                   = "10.0.2.0/24"
      service_endpoints      = ["Microsoft.Storage", "Microsoft.KeyVault"]
      private_endpoint_enabled = true
    }
    functions = {
      cidr                   = "10.0.3.0/24"
      service_endpoints      = ["Microsoft.Storage", "Microsoft.KeyVault"]
      private_endpoint_enabled = true
    }
    private-endpoints = {
      cidr                   = "10.0.4.0/24"
      service_endpoints      = []
      private_endpoint_enabled = true
    }
  }
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}

variable "private_dns_zones" {
  type        = map(string)
  default     = {}
  description = "Map of private DNS zones to create"
}
