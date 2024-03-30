variable "prod_resource_group_name" {
  type        = string
  description = "Prod resource group name."
}

variable "prod_resource_group_sqlserver" {
  type        = string
  description = "Prod sql server resource group name."
}

variable "prod_cluster_name" {
  type        = string
  description = "The production cluster name"
}

variable "prod_mssql_name" {
  type        = string
  description = "The production Azure SQL server name"
  sensitive   = true
}

variable "prod_mssql_full_name" {
  type        = string
  description = "The production Azure SQL server full name"
  sensitive   = true
}

variable "prod_sql_db" {
  type        = string
  description = "The production Azure SQL db name"
}

variable "docker_image" {
  type        = string
  description = "The docker image name"
}

variable "random_uuid" {
  type        = string
  description = "Identifier for uuid label"
  default     = "00000000-0000-0000-0000-000000000001"
}

variable "prod_pricing_password" {
  type        = string
  description = "Password for PricingSystemUser"
}

variable "prod_key_vault_name" {
  type        = string
  description = "The production key vault name"
}