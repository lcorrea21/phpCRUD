variable "resource_group_name" {
  type        = string
  description = "Resource group name."
}

variable "resource_pricing_service" {
  type        = string
  description = "Pricing Service resource group name."
}

variable "cluster_name" {
  type        = string
  description = "The cluster name for testing purposes"
}

variable "rps_name" {
  type        = string
  description = "The rps name of the git branch"
}

variable "mssql_name" {
  type        = string
  description = "Azure SQL server name"
  sensitive   = true
}

variable "mssql_full_name" {
  type        = string
  description = "Azure SQL server full name"
  sensitive   = true
}

variable "sql_db" {
  type        = string
  description = "Azure SQL db name"
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

variable "key_vault_name" {
  type        = string
  description = "The QA key vault name"
}