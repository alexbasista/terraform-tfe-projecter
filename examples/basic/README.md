# Projecter Example - Basic
In this example, the module call creates a Project within the Organization specified, with no additional arguents or configurations.

## Usage
```hcl
module "projecter" {
  source  = "alexbasista/projecter/tfe"
  version = "0.1.0"
  
  organization = "my-tfc-org"
  project_name = "my-new-project"
}
```