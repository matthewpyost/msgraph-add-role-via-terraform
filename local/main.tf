terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

module "msgraph_app_role_assignment" {
  source = "../module"
  principal_object_id = var.principal_object_id
  roles = var.roles
}