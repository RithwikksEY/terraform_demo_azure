provider "azurerm" {
  features {}
}
 
resource "azurerm_resource_group" "example" {
  name     = "rg-hcp-terraform-test"
  location = "East US"
}
