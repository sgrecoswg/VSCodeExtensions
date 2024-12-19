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

variable "region" {
  description = "region we are deploying to"
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
