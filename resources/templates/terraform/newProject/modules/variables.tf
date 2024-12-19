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