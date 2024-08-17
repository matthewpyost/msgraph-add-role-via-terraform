terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"

  backend "azurerm" {
    resource_group_name  = var.backend_resource_group_name
    storage_account_name = var.backend_storage_account_name
    container_name       = var.backend_container_name
    key                  = var.backend_key
    use_oidc             = true
  }
}

provider "azuread" {
  use_oidc = true
}

module "msgraph_app_role_assignment" {
  source = "../module"
  principal_object_id = var.principal_object_id
  roles = var.roles
}