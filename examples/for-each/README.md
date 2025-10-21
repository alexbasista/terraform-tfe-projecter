# Projecter Example - For-Each

In this example, the consumer creates a complex input variable type called `projects` that is a map of objects to enable the creation and management of multiple projects via a `for_each` meta-argument inside of our module block.


```hcl
module "projects" {
  for_each = var.projects
  source   = "alexbasista/projecter/tfe"
  version  = "x.x.x"

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
  my-new-prj-1 = {
    team_access = {
      example-platform-team = "admin"
      example-app-team-1    = "maintain"
    }
    variable_set_names = ["example-varset-1", "example-varset-2"]
    policy_set_names   = ["example-polset-1", "example-polset-a"]
  }
  my-new-prj-2 = {
    team_access = {
      example-platform-team = "admin"
      example-app-team-2    = "write"
    }
    variable_set_names = ["example-varset-3", "example-varset-4"]
    policy_set_names   = ["example-polset-1", "example-polset-b"]
  }
}
```