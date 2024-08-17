variable "backend_resource_group_name" {
  type = string
}

variable "backend_storage_account_name" {
  type = string
}

variable "backend_container_name" {
  type = string
  default = "tfstate"
}

variable "backend_key" {
  type = string
  default = "terraform.tfstate"
}

variable "roles" {
    type = list(string)
}

variable "principal_object_id" {
  type = string
}
