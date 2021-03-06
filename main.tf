# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }
  }
  required_version = ">= 0.14.9"
}
provider "azurerm" {
  features {}
}
variable "app_service_enabled" {
  type    = bool
  default = true
}
variable "branch_to_deploy" {
  type    = string
  default = "master"
}
# Generate a random integer to create a globally unique name
resource "random_integer" "ri" {
  min = 10000
  max = 99999
}
# Create the resource group
resource "azurerm_resource_group" "rg" {
  name     = "myResourceGroup-${random_integer.ri.result}"
  location = "eastus"
}
# Create the Linux App Service Plan
resource "azurerm_app_service_plan" "appserviceplan" {
  name                = "webapp-asp-${random_integer.ri.result}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku {
    tier = "Free"
    size = "F1"
  }
}
# Create the web app, pass in the App Service Plan ID, and deploy code from a public GitHub repo
resource "azurerm_app_service" "webapp" {
  name                = "webapp-${random_integer.ri.result}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.appserviceplan.id
  enabled             = var.app_service_enabled
  logs {
    application_logs {
      file_system_level = "Information"
    }
  }
  app_settings = {
    "WEBSITE_NODE_DEFAULT_VERSION" = "16.13.0"
  }
  source_control {
    repo_url           = "https://github.com/positivejam/nodejs-docs-hello-world"
    branch             = var.branch_to_deploy
    manual_integration = true
    use_mercurial      = false
  }
}