terraform {
  cloud {
    organization = "Terraform-Learning-Rithwik"
 
    workspaces {
      name = "terraform_demo_azure"
    }
  }
 
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

terraform {
  required_version = ">= 1.5.0"
 
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}
