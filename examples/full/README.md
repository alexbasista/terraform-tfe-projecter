# Projecter Example - Full

In this example, a project is created with additional settings specified:
 
 - [team access](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/team_project_access)
 - [custom team access](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/team_project_access#custom-access)
 - [variable sets](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/project_variable_set)
 - [policy sets](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/project_policy_set)

## Usage

```hcl
module "projecter" {
  source  = "alexbasista/projecter/tfe"
  version = "x.x.x"

  organization = "my-tfc-org"
  project_name = "my-new-project"

  team_access = {
    example-platform-team = "admin"
    example-app-team-1    = "maintain"
  }

  custom_team_access = {
    example-app-team-2 = {
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
    example-ops-team = {
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

  variable_set_names = ["example-varset-1", "example-varset-2"]
  policy_set_names   = ["example-polset-1", "example-polset-2"]
}
```