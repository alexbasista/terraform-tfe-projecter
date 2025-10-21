# Projecter

Terraform module to create and configure Projects in Terraform Cloud/Enterprise, with a similar look and feel to [workspacer](https://registry.terraform.io/modules/alexbasista/workspacer/tfe/latest).

## Usage

```hcl
module "projecter" {
  source  = "alexbasista/projecter/tfe"
  version = "x.x.x"

  organization = "my-tfc-org"
  project_name = "my-new-project"
  description  = "My project description"
  tags = {
    environment = "production"
    team        = "platform"
  }

  team_access = {
    example-team-1 = "admin"
    example-team-2 = "write"
  }
}
```
> Note: Setting a `TFE_TOKEN` environment variable is the recommended approach for the TFE provider auth. Alternatively, you could run `terraform login`.

See the [examples](./examples/) directory for more detailed scenarios.

### Project Description and Tags
The `description` and `tags` input variables are optional and can be used to provide additional metadata for the Project.

```hcl
  description = "Production environment project"
  tags = {
    environment = "production"
    service     = "aws"
    team        = "platform"
  }
```

### Team Access

To configure RBAC on the Project, there are two options:

#### Fixed Permission Sets

The `team_access` input varible accepts a map of strings whereby each key/value pair is the (existing) team name and [fixed permission set](https://developer.hashicorp.com/terraform/cloud-docs/users-teams-organizations/permissions#fixed-permission-sets-1). Valid permission sets are `admin`, `maintain`, `write`, or `read`.

```hcl
  team_access = {
    dev-team     = "read"
    release-team = "write"
    tfc-admins   = "admin"
  }
```

#### Custom Project Permissions

The `custom_team_access` input variable accepts a map of objects whereby each object represents a set of custom team project permissions to assign to the Project. Each object has two child objects: `project_access` and `workspace_access`.  See the [custom access docs](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/team_project_access#custom-access) for permissions descriptions, defaults, and valid values.

```hcl
  custom_team_access = {
    example-team-1 = {
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
```

### Variable Sets

To apply a Variable Set to the Project, the input variable `variable_set_names` accepts a list of existing Variable Set names to apply.

```hcl
  variable_set_names = [
    "example-varset-1",
    "example-varset-2"
  ]
```

### Policy Sets

To enforce a Policy Set on the Project, the input variable `policy_set_names` accepts a list of existing Policy Set names to enforce.

```hcl
  policy_set_names = [
    "example-polset-1",
    "example-polset-2"
  ]
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.0 |
| <a name="requirement_tfe"></a> [tfe](#requirement\_tfe) | >= 0.51.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_tfe"></a> [tfe](#provider\_tfe) | >= 0.51.1 |

## Resources

| Name | Type |
|------|------|
| [tfe_project.project](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/project) | resource |
| [tfe_project_policy_set.ps](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/project_policy_set) | resource |
| [tfe_project_variable_set.vs](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/project_variable_set) | resource |
| [tfe_team_project_access.custom](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/team_project_access) | resource |
| [tfe_team_project_access.managed](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/team_project_access) | resource |
| [tfe_policy_set.ps](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/data-sources/policy_set) | data source |
| [tfe_team.custom](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/data-sources/team) | data source |
| [tfe_team.managed](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/data-sources/team) | data source |
| [tfe_variable_set.vs](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/data-sources/variable_set) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_organization"></a> [organization](#input\_organization) | Name of Organization to create Project in. | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Name of Project. | `string` | n/a | yes |
| <a name="input_custom_team_access"></a> [custom\_team\_access](#input\_custom\_team\_access) | Map of existing Team(s) and custom permissions to grant on Project. If used, all keys in the object must be specified. | <pre>map(<br/>    object({<br/>      project_access = object({<br/>        settings = string<br/>        teams    = string<br/>      })<br/>      workspace_access = object({<br/>        create         = bool<br/>        delete         = bool<br/>        move           = bool<br/>        runs           = string<br/>        variables      = string<br/>        state_versions = string<br/>        sentinel_mocks = string<br/>        run_tasks      = bool<br/>        locking        = bool<br/>      })<br/>    })<br/>  )</pre> | `{}` | no |
| <a name="input_policy_set_names"></a> [policy\_set\_names](#input\_policy\_set\_names) | List of names of existing Policy Set(s) to enforce on Project. Policy Set(s) cannot be global. | `list(string)` | `[]` | no |
| <a name="input_team_access"></a> [team\_access](#input\_team\_access) | Map of existing Team(s) and built-in permissions to grant on Project. | `map(string)` | `{}` | no |
| <a name="input_variable_set_names"></a> [variable\_set\_names](#input\_variable\_set\_names) | List of names of existing Variable Set(s) to apply to Project. Variable Set(s) cannot be global. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_custom_team_access_ids"></a> [custom\_team\_access\_ids](#output\_custom\_team\_access\_ids) | Map of team names to their project access resource IDs (custom permissions). |
| <a name="output_organization"></a> [organization](#output\_organization) | Organization that the project belongs to |
| <a name="output_policy_set_ids"></a> [policy\_set\_ids](#output\_policy\_set\_ids) | Map of policy set names to their IDs enforced on the project |
| <a name="output_project_id"></a> [project\_id](#output\_project\_id) | ID of the project |
| <a name="output_project_name"></a> [project\_name](#output\_project\_name) | Name of the project |
| <a name="output_project_policy_set_ids"></a> [project\_policy\_set\_ids](#output\_project\_policy\_set\_ids) | Map of policy set names to their project policy set resource IDs |
| <a name="output_project_variable_set_ids"></a> [project\_variable\_set\_ids](#output\_project\_variable\_set\_ids) | Map of variable set names to their project variable set resource IDs |
| <a name="output_team_access_ids"></a> [team\_access\_ids](#output\_team\_access\_ids) | Map of team names to their project access resource IDs (fixed permissions) |
| <a name="output_variable_set_ids"></a> [variable\_set\_ids](#output\_variable\_set\_ids) | Map of variable set names to their IDs applied to the project |
<!-- END_TF_DOCS -->