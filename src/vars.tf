variable "environment" {
    type                        = string
}

variable "org" {
    type            = string
    default         = "MPIS"
}

variable "org_service_url" {
    type            = string
    default         = "__orgserviceurl__"
}

#commmon tags
variable "azure_location" {
    type            = string
    default         = "West Europe"
}

variable "azure_common_tags" {
    type = map
    default = {
        vendor                  = "UNIR",
        iac                     = "terraform"
        support                 = "lmfespinosa@gmail.com"
    }
}

# Random string
# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string

resource "random_string" "random" {
  length                        = 5
  upper                         = false
  lower                         = true
  number                        = false
  special                       = false
}

resource "random_password" "password" {
  length                        = 30
  special                       = true
  override_special              = "_%@"
}