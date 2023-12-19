# Projecter
Terraform module to create and configure Projects in Terraform Cloud/Enterprise, with a similar look and feel to [workspacer](https://registry.terraform.io/modules/alexbasista/workspacer/tfe/latest).

## Usage
```hcl
module "projecter" {
  source  = "alexbasista/projecter/tfe"
  version = "0.1.0"

  organization = "my-tfc-org"
  project_name = "my-new-project"

  team_access = {
    tfc-admins = "admin"
    app-team   = "write"
  }
}
```
> Note: Setting a `TFE_TOKEN` environment variable is the recommended approach for the TFE provider auth. Alternatively, you could run `terraform login`.


See the [examples](./examples/) directory for more detailed scenarios.
