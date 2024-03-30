data "azurerm_resource_group" "UC1-PricingService" {
  name = var.resource_group_name
}

data "azurerm_resource_group" "rg-pricingservice-dev-001" {
  name = var.resource_pricing_service
}

data "azurerm_kubernetes_cluster" "qarpsclstr2" {
  name                = var.cluster_name
  resource_group_name = data.azurerm_resource_group.UC1-PricingService.name
}

data "azurerm_mssql_server" "mssqlserver" {
  name                = var.mssql_name
  resource_group_name = data.azurerm_resource_group.rg-pricingservice-dev-001.name
}

data "azurerm_mssql_database" "mssqldb" {
  name      = var.sql_db != "PricingService" ? "PricingService" : "master"
  server_id = data.azurerm_mssql_server.mssqlserver.id
}

data "azurerm_key_vault" "akvpricingservice" {
  name                = var.key_vault_name
  resource_group_name = data.azurerm_resource_group.rg-pricingservice-dev-001.name
}

resource "azurerm_mssql_database" "mssqldatabase" {
  name                        = var.sql_db
  server_id                   = data.azurerm_mssql_server.mssqlserver.id
  auto_pause_delay_in_minutes = 60
  collation                   = "SQL_Latin1_General_CP1_CI_AS"
  read_replica_count          = 0
  read_scale                  = false
  max_size_gb                 = 10
  min_capacity                = 0.5
  sku_name                    = "GP_S_Gen5_2"
  storage_account_type        = "Local"
  create_mode                 = var.sql_db == "PricingService" ? "Default" : "Copy"
  creation_source_database_id = var.sql_db == "PricingService" || data.azurerm_mssql_database.mssqldb.name == "master" ? null : data.azurerm_mssql_database.mssqldb.id
  tags                        = {
    "application" = "REV"
  }
}

data "kubectl_path_documents" "docs" {
  pattern = "./manifests/*.yaml"
  vars    = {
    random_uuid         = var.random_uuid
    rps_name            = var.rps_name
    sql_db              = var.sql_db
    sql_server          = var.mssql_full_name
    docker_image        = var.docker_image
    azure_key_vault_url = data.azurerm_key_vault.akvpricingservice.vault_uri
  }
}

resource "kubectl_manifest" "test" {
  for_each  = data.kubectl_path_documents.docs.manifests
  yaml_body = each.value
}