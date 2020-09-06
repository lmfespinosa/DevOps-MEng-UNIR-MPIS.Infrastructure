# Create a specific Git repository by name
data "azuredevops_git_repository" "user_repository" {
  project_id = data.azuredevops_project.project.id
  name       = "MPIS.User"


 
}

data "azuredevops_git_repository" "device_repository" {
  project_id = data.azuredevops_project.project.id
  name       = "MPIS.Device"


}

data "azuredevops_git_repository" "spa_repository" {
  project_id = data.azuredevops_project.project.id
  name       = "MPIS.Admin.SPA"


 
}

data "azuredevops_git_repository" "agent_repository" {
  project_id = data.azuredevops_project.project.id
  name       = "MPIS.InventoryAgent"


 
}

