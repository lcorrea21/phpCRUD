terraform {
  required_version = "1.5.7"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.42.0"
    }

    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.14.0"
    }

  }

  backend "azurerm" {
  }
}

provider "azurerm" {

  features {}
}

provider "kubectl" {
  host                   = data.azurerm_kubernetes_cluster.qarpsclstr2.kube_config.0.host
  client_certificate     = base64decode(data.azurerm_kubernetes_cluster.qarpsclstr2.kube_config.0.client_certificate)
  client_key             = base64decode(data.azurerm_kubernetes_cluster.qarpsclstr2.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.qarpsclstr2.kube_config.0.cluster_ca_certificate)
  load_config_file       = false
}