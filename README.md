# Projecter
Terraform module to create and configure Projects in Terraform Cloud/Enterprise, with a similar look and feel to [workspacer](https://registry.terraform.io/modules/alexbasista/workspacer/tfe/latest).

## Usage
```hcl
module "projecter" {
  source  = "alexbasista/projecter/tfe"
  version = "0.1.1"

  organization = "my-tfc-org"
  project_name = "my-new-project"
  description  = "My project description"
  tags = {
    environment = "production"
    team        = "platform"
  }

  team_access = {
    tfc-admins = "admin"
    app-team   = "write"
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
```

### Variable Sets
To apply a Variable Set to the Project, the input variable `variable_set_names` accepts a list of existing Variable Set names to apply.

```hcl
  variable_set_names = [
    "my-aws-creds",
    "tfe-api-token"
  ]
```

### Policy Sets
To enforce a Policy Set on the Project, the input variable `policy_set_names` accepts a list of existing Policy Set names to enforce.

```hcl
  policy_set_names = [
    "sentinel-global",
    "sentinel-aws"
  ]
```