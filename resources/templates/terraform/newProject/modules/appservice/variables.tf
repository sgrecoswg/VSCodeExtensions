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

variable "rg-name" {
  description = "The name of the app"
  type        = string
  default     = "notset"
}

variable "rg-location" {
  description = "The name of the app"
  type        = string
  default     = "notset"
}

variable "region" {
  description = "The name of the app"
  type        = string
  default     = "notset"
}

variable "app-settings" {
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

variable "connection-string" {
   description = "The name of the app"
   type        = any
   default     = {}   
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