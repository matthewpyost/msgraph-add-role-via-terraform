# Automation via GitHub Actions

This execution option is provided to enable engineers, such as Software Engineers, who don't have the required Azure access to easily add MS Graph application roles to a target identity via a GitHub Action.

## GitHub Workflow

The [main](../.github/workflows/main.yml) GitHub workflow is responsible for applying the Terraform [configuration](./main.tf). Rather than being triggered by a pull request of commit, it will be triggered manually via the "Run workflow" button on the "Actions" tab in GitHub.

Engineers who need to be able to execute the workflow will need the necessary access and permissions to the GitHub repository.

## Getting Started

To use the above workflow in your environment, a DevOps/Cloud engineers will need to be sure to perform the following to configure the GitHub action.

1. **Create GitHub Environments**

    The workflows utilizes GitHub Environments and Secrets to store the azure identity information and setup an approval process for deployments. Create an aptly named environment for each Azure Tenant to be interfaced with by following these [instructions](https://docs.github.com/actions/deployment/targeting-different-environments/using-environments-for-deployment#creating-an-environment).

2. **Configure Terraform State Location**

    Terraform utilizes a [state file](https://www.terraform.io/language/state) to store information about the current state of your managed infrastructure and associated configuration. This file will need to be persisted between different runs of the workflow. This solution is currently configured to store this file within an Azure Storage Account. If you wish to change the backend storage to another provider, update the [Terraform backend block](main.tf#L12-L17) with your preferred provider. For the current configuration using Azure Storage Account, add the following environment variables to each Azure for each environment you created above:

    - `BACKEND_RESOURCE_GROUP_NAME` : The name of the Azure Resource group that contains the Azure Storage account you wish to use as backend storage
    - `BACKEND_STORAGE_ACCOUNT_NAME` : The name of the Azure Storage Account you wish to use as backend storage
    - `BACKEND_CONTAINER_NAME` : The name of the storage container in the Azure Storage Account you wish to use as backend storage
    - `BACKEND_KEY` : The key to be used in the storage container in the Azure Storage Account you wish to use as backend storage

3. **Setup Azure Identity**:

    An Azure Active Directory application is required that has permissions to deploy within your Azure subscription. For each environment created above, create or identify an Azure Active Directory application that has the [required roles](../README.md#service-principal). In addition, if using a storage account to maintain state, be sure each Service Principal has at least the `Reader and Data Access` permissions. Next, setup the federated credentials to allow GitHub to utilize the identity using OIDC. See the [Azure documentation](https://docs.microsoft.com/azure/developer/github/connect-from-azure?tabs=azure-portal%2Clinux#use-the-azure-login-action-with-openid-connect) for detailed instructions.

4. **Add GitHub Secrets**

    For each Azure Directory Application created above, create the following secrets in the appropriate environment:

    - `AZURE_CLIENT_ID` : The application (client) ID of the app registration in Azure
    - `AZURE_TENANT_ID` : The tenant ID of Azure Active Directory where the app registration is defined.
    - `AZURE_SUBSCRIPTION_ID` : The subscription ID where the app registration is defined.

    Instructions to add the secrets to the environment can be found [here](https://docs.github.com/actions/security-guides/encrypted-secrets#creating-encrypted-secrets-for-an-environment).

