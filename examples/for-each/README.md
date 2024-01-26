# For-Each Example
In this example, we as the consumer create a complex input variable type called `projects` that is a map of objects to enable the creation and management of multiple Projects via a `for_each` meata-argument inside of our module block.


```hcl
module "projects" {
  for_each = var.projects
  source   = "alexbasista/projecter/tfe"
  version  = "0.2.0"

  organization = var.organization
  project_name = each.key

  team_access        = each.value.team_access
  custom_team_access = each.value.custom_team_access
  variable_set_names = each.value.variable_set_names
  policy_set_names   = each.value.policy_set_names
}
```
  
  
**terraform.tfvars:**
```hcl
organization = "my-tfc-org"

projects = {
  my-prj-1 = {
    team_access = {
      tfc-owners = "admin"
      app-team-1 = "maintain"
    }
    variable_set_names = ["aws-creds-1", "tfe-team-token-1"] # must be non-global variable set
    policy_set_names   = ["aws-policies", "prj-1-policies"]  # must be non-global policy set
  }
  my-prj-2 = {
    team_access = {
      tfc-owners = "admin"
      app-team-2 = "write"
    }
    variable_set_names = ["aws-creds-2", "tfe-team-token-2"] # must be non-global variable set
    policy_set_names   = ["aws-policies", "prj-2-policies"]  # must be non-global policy set
  }
}
```