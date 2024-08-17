variable "allowed_roles" {
  type = list(string)
  default =  [ "Directory.Read.All", "User.Read.All", "Group.Read.All", "Application.ReadWrite.OwnedBy" ]
}

variable "roles" {
    type = list(string)
    validation {
        condition = alltrue([
            for o in var.roles : contains(var.allowed_roles, o)
        ])
        error_message = format("Valid values for variable 'roles' are '%s'.", join(", '",var.allowed_roles))
  } 
}

variable "principal_object_id" {
  type = string
}