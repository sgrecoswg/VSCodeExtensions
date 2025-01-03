variable "should-deploy" {
    description = ""
    type  = bool
    default = false
}

variable "app-env" {
  description = "environment we are deploying to"
  type        = string
  default     = "notset"
}

variable "app-name" {
  description = "The name of the app"
  type        = string
  default     = "notset"
}

variable "region" {
  description = "region for environment"
  type        = map(any)
}

variable "msi_id" {
  type        = string
  description = "The Managed Service Identity ID. If this value isn't null (the default), 'data.azurerm_client_config.current.object_id' will be set to this value."
  default     = null
}

variable "virtual-network-ip-set" {
  description = "The name of the app"
  type        = list
}

variable "virtual-subnet-ip-set" {
  description = "The name of the app"
  type        = list
}

variable "virtual-failover-subnet-ip-set" {
  description = "The name of the app"
  type        = list
}

variable "gw-path" {
  description = "The name of the app"
  type        = string
}

variable "sku" {
  description = "The name of the app"
  type        = string
  default     = "notset"
}

variable "os" {
  description = "The name of the app"
  type        = string
  default     = "notset"
}

variable "connection-string" {
   description = "The name of the app"
   type        = any
   default     = {}   
}

variable "dotnet-framework" {
  description = "The name of the app"
  type        = string
  default     = "notset"
}

variable "source-control" {
  description = "The name of the app"
  type        = string
  default     = "notset"
}