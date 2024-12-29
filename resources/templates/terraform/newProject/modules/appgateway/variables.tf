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
  type        = string
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