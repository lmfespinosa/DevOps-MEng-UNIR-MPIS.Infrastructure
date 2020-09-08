resource "null_resource" "execute-pipe-user-dev" {

#az account set --subscription "Company Subscription"
    #connection {
    #    type = "ssh"
    #    user = "azureuser"
    #    password = "azureuser@2018"
    #    host = "13.92.255.50"
    #    port = 22
    #}
    #provisioner "file" {
    #    source = "script.sh"
    #    destination = "/tmp/script.sh"
    #}

    provisioner "local-exec" {
        command = "echo ${var.pat_devops} | az devops login && az devops configure --defaults organization=${var.org_service_url} && az pipelines run --project=${data.azuredevops_project.project.id} --name=MPIS.User-CI-CD-dev --org=${var.org_service_url}/"
        
    }

    depends_on = [azuredevops_variable_group.variablegroup]
}


resource "null_resource" "execute-pipe-device-dev" {

#az account set --subscription "Company Subscription"
    #connection {
    #    type = "ssh"
    #    user = "azureuser"
    #    password = "azureuser@2018"
    #    host = "13.92.255.50"
    #    port = 22
    #}
    #provisioner "file" {
    #    source = "script.sh"
    #    destination = "/tmp/script.sh"
    #}

    provisioner "local-exec" {
        command = "echo ${var.pat_devops} | az devops login && az devops configure --defaults organization=${var.org_service_url} && az pipelines run --project=${data.azuredevops_project.project.id} --name=MPIS.Device-CI-CD-dev --org=${var.org_service_url}/"
        
    }

    depends_on = [azuredevops_variable_group.variablegroup]
}

resource "null_resource" "execute-pipe-admin-spa-dev" {

#az account set --subscription "Company Subscription"
    #connection {
    #    type = "ssh"
    #    user = "azureuser"
    #    password = "azureuser@2018"
    #    host = "13.92.255.50"
    #    port = 22
    #}
    #provisioner "file" {
    #    source = "script.sh"
    #    destination = "/tmp/script.sh"
    #}

    provisioner "local-exec" {
        command = "echo ${var.pat_devops} | az devops login && az devops configure --defaults organization=${var.org_service_url} && az pipelines run --project=${data.azuredevops_project.project.id} --name=MPIS.Admin.SPA-CI-CD-dev --org=${var.org_service_url}/"
        
    }

    depends_on = [azuredevops_variable_group.variablegroup]
}

