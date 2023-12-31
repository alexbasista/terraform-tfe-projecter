# Projecter Example - Full
In this example, the module call creates a Project within the specified Organization,
and configures the Project to include the following:
 - [team access](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/team_project_access)
 - [custom team access](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/team_project_access#custom-access)
 - [variable sets](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/project_variable_set)
 - [policy sets](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/project_policy_set)

## Usage
```hcl
module "projecter" {
  source  = "alexbasista/projecter/tfe"
  version = "0.1.0"

  organization = "my-tfc-org"
  project_name = "my-new-project"

  team_access = {
    tfc-admins = "admin"
    app-team   = "maintain"
  }

  custom_team_access = {
    governance-team = {
      project_access = {
        settings = "read"
        teams    = "read"
      }
      workspace_access = {
        create         = false
        delete         = false
        move           = true
        runs           = "read"
        variables      = "read"
        state_versions = "write"
        sentinel_mocks = "read"
        run_tasks      = true
        locking        = false
      }
    }
    operations-team = {
      project_access = {
        settings = "update"
        teams    = "read"
      }
      workspace_access = {
        create         = true
        delete         = true
        move           = false
        runs           = "apply"
        variables      = "write"
        state_versions = "read-outputs"
        sentinel_mocks = "none"
        run_tasks      = false
        locking        = true
      }
    }
  }

  variable_set_names = ["aws-creds", "tfe-api-token"]
  policy_set_names   = ["sentinel-global-policies", "sentinel-aws-policies"]
}
```