
# Microsoft Graph Role Assignment Solution

The following solution is offered to simplify assigning an existing Azure Managed Identity with one ore more Microsoft Graph application roles. For more information on Microsoft Graph permissions, review ["Overview of Microsoft Graph permissions"](https://learn.microsoft.com/en-us/graph/permissions-overview?tabs=http).

## Supported Roles

Please note that currently this solution is limited to only assigning the below pre-approved Microsoft Graph application roles.

- Directory.Read.All
- User.Read.All
- Group.Read.All
- Application.ReadWrite.OwnedBy

## Authentication

Since this utility is interfacing with an Microsoft Entra ID tenant, the identity used to communicate with Azure requires a specific sets of roles.

### User Principal

If authenticating with an Azure User Principal resource, it requires one of the following directory roles:

- **Application Administrator**
- **Global Administrator**

### Service Principal

If authenticating with an Azure Service Principal resource, it requires the following application roles:

- **Application.ReadWrite.OwnedBy** or **Application.ReadWrite.All**
- **AppRoleAssignment.ReadWrite.All** and **Application.Read.All** or **AppRoleAssignment.ReadWrite.All** and **Directory.Read.All** or **Application.ReadWrite.All** or **Directory.ReadWrite.All**

## Local Execution

The solution can be run locally to support programmatic execution or for Cloud Engineers who have the necessary access and local prerequisites to run locally. More details about the running locally can be found at [/local/README.md](./local/README.md).

## Automated Execution

