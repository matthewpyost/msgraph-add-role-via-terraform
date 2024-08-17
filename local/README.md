# Executing Locally

This execution option is provided since it was already developed before the additional requirement was provided for the solution to run on an automation platform (ex. GitHubAction). This approach is probably best for Cloud Engineers who may already have the prerequisites and necessary authentication access.

## Prerequisites

Running locally requires the following software to be installed on the machine where the utility will be executed:

- [User Principal](../README.md#user-principal) or [Service Principal](../README.md#service-principal) credential
- Windows 10 or later
- PowerShell 5.1 or later
- Terraform 0.14.9 or later
- Azure CLI 2.6 or later

### Install Terraform

If you don't already have Terraform installed, options and details for installing Terraform can be found [here](https://developer.hashicorp.com/terraform/tutorials/azure-get-started/install-cli). If you choose to  manually install, make sure that the terraform binary is available on your PATH.

### Install the Azure CLI

Open your PowerShell prompt as an administrator and run the following command:

```powershell
$Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi; Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'; rm .\AzureCLI.msi
```

## Execution

Local execution is as simple as executing the "run.ps1" PowerShell file with, at minimum, the required arguments detailed below. It is recommended that the script is run within the directory containing this utility.

### Required Arguments

- `subscriptionId`: the ID of the Azure subscription that contains the Managed Identity to be updated
- `tenantId`: the ID of the Azure tenant that contains the Managed Identity to be updated
- `targetPrincipalId`: the object ID of the Managed Identity to be updated
- `roles`: one or more of the [supported Graph app roles](../README.md#supported-roles) to be assigned

### Optional Arguments

- `useCachedIdentity`: uses the cached Azure CLI credentials, if available; otherwise will attempt to authenticate based on the arguments provided
- `principalId`: the App ID of the Azure Service Principal you would like to use to authenticated with the Azure CLI; if not provided login to the Azure CLI will use the user principal interactive login
- `principalSecret`: the client secret (password) or path to the client certificate of the Azure Service Principal you would like to use to authenticate with Azure CLI; if not provided and "principalId" argument is, you will be prompted to provide the client secret

### Example 1: Authenticates using Interactive login w/ two roles being assigned

```powershell
.\run.ps1 -subscriptionId "0f7699c5-be05-4833-975d-f2d7613b3d03" -tenantId "49cd43d1-f512-41eb-9669-26aeb210e706" -targetPrincipalId "95380960-d494-4d56-b667-4842f4b8d1f4" -roles "Directory.Read.All", "User.Read.All"
```

### Example 2: Skips interactive login if credentials already cached

```powershell
.\run.ps1 -subscriptionId "0f7699c5-be05-4833-975d-f2d7613b3d03" -tenantId "49cd43d1-f512-41eb-9669-26aeb210e706" -targetPrincipalId "95380960-d494-4d56-b667-4842f4b8d1f4" -roles "Directory.Read.All" -useCachedIdentity
```

### Example 3: Authenticates using an Azure Service Principal (will be prompted for client secret)

```powershell
.\run.ps1 -subscriptionId "0f7699c5-be05-4833-975d-f2d7613b3d03" -tenantId "49cd43d1-f512-41eb-9669-26aeb210e706" -targetPrincipalId "95380960-d494-4d56-b667-4842f4b8d1f4" -roles "Directory.Read.All" -principalId "TestServicePrincipal"
```

### Example 4: Authenticates using an Azure Service Principal w/ client password

```powershell
.\run.ps1 -subscriptionId "0f7699c5-be05-4833-975d-f2d7613b3d03" -tenantId "49cd43d1-f512-41eb-9669-26aeb210e706" -targetPrincipalId "95380960-d494-4d56-b667-4842f4b8d1f4" -roles "Directory.Read.All" -principalId "TestServicePrincipal" -principalSecret "P@ssw0rd!"
```

### Example 5: Authenticates using an Azure Service Principal w/ client certificate

```powershell
.\run.ps1 -subscriptionId "0f7699c5-be05-4833-975d-f2d7613b3d03" -tenantId "49cd43d1-f512-41eb-9669-26aeb210e706" -targetPrincipalId "95380960-d494-4d56-b667-4842f4b8d1f4" -roles "Directory.Read.All" -principalId "TestServicePrincipal" -principalSecret "~/mycertfile.pem"
```
