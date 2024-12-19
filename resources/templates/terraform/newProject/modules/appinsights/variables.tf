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