# Projecter Example - Basic

In this example, a plain project within the specified organization, with no additional settings.

## Usage

```hcl
module "projecter" {
  source  = "alexbasista/projecter/tfe"
  version = "x.x.x"
  
  organization = "my-tfc-org"
  project_name = "my-new-project"
}
```