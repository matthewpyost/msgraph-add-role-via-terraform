data "azuread_application_published_app_ids" "well_known" {}

resource "azuread_service_principal" "msgraph" {
  client_id    = data.azuread_application_published_app_ids.well_known.result.MicrosoftGraph
  use_existing = true
}

data "azuread_service_principal" "target" {
  object_id = var.principal_object_id
}

resource "azuread_app_role_assignment" "target" {
    for_each            = toset(var.roles)
    app_role_id         = azuread_service_principal.msgraph.app_role_ids["${each.key}"]
    principal_object_id = var.principal_object_id
    resource_object_id  = azuread_service_principal.msgraph.object_id
}