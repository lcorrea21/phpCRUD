data "azurerm_resource_group" "UC1RevProd1" {
  name = var.prod_resource_group_name
}

data "azurerm_resource_group" "UC1-SQL" {
  name = var.prod_resource_group_sqlserver
}

data "azurerm_kubernetes_cluster" "UC1RevProd1" {
  name                = var.prod_cluster_name
  resource_group_name = data.azurerm_resource_group.UC1RevProd1.name
}

data "azurerm_mssql_server" "mssqlserver" {
  name                = var.prod_mssql_name
  resource_group_name = data.azurerm_resource_group.UC1-SQL.name
}

data "azurerm_key_vault" "akvpricingservice" {
  name                = var.prod_key_vault_name
  resource_group_name = "ProdPricingService"
}

resource "azurerm_mssql_database" "mssqldatabase" {
  name                        = var.prod_sql_db
  server_id                   = data.azurerm_mssql_server.mssqlserver.id
  auto_pause_delay_in_minutes = 0
  collation                   = "SQL_Latin1_General_CP1_CI_AS"
  read_replica_count          = 0
  read_scale                  = false
  max_size_gb                 = 1536
  min_capacity                = 0
  sku_name                    = "ElasticPool"
  storage_account_type        = "Geo"
  elastic_pool_id             = "/subscriptions/41ceaa2f-0883-4cb6-a758-6a82998f8d87/resourceGroups/UC1-SQL/providers/Microsoft.Sql/servers/revuc1cfoprsq01/elasticPools/REVUC1CFOPREP01"
  tags                        = {
    "application" = "REV"
  }
  timeouts {}
}

data "kubectl_path_documents" "docs" {
  pattern = "./manifests/*.yaml"
  vars    = {
    random_uuid         = var.random_uuid
    sql_db              = var.prod_sql_db
    sql_server          = var.prod_mssql_full_name
    docker_image        = var.docker_image
    pricing_pwd         = var.prod_pricing_password
    azure_key_vault_url = data.azurerm_key_vault.akvpricingservice.vault_uri
  }
}

resource "kubectl_manifest" "prod" {
  for_each  = data.kubectl_path_documents.docs.manifests
  yaml_body = each.value
}