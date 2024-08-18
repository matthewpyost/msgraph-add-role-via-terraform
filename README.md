
# Microsoft Graph Role Assignment via GitHub

The following solution is offered to simplify assigning an existing Azure Managed Identity with one ore more Microsoft Graph application roles via a GitHub Action. For more information on Microsoft Graph permissions, review ["Overview of Microsoft Graph permissions"](https://learn.microsoft.com/en-us/graph/permissions-overview?tabs=http).

## Setup

Before engineers can use this solution, the workflow needs to be setup and made available to those engineers who should have the ability to add MS Graph app roles to Managed Identities. Details on how to setup the workflow can be found [here](/setup.md).

## Execution

Executing the workflow first will require the above setup to be completed by the DevOps team. Contact your DevOps team for access and details as to where the GitHub repository is located. Once you have access, navigate to the `Actions` screan in the GitHup repo and click on the `Main` workflow located in the left nav. Once the `Main` is selected, click on the "Run workflow" button, as seen below:

![image](/images/run-workflow-button.png)

After clicking the "Run workflow" button, you will be prompted for the following information:

- `Environment` : this will be the environment you wish to perform the change in. Contact your DevOps team for which environment you should use if you are unsure.
- `Managed Identity` : this will be the object ID of the Managed Identity in the environment you selected that you wish to add MS Graph roles to. Contact your DevOps team if you don't know what value to put here.
- `Roles` : this will be a comma delimited list of pre-approved roles you would like to add to the Managed Identity.

Below is an example of the input prompt and some sample values:

![image](/images/run-workflow-prompt.png)

Once you click on the "Run workflow" button within the input prompt, the workflow will shortly kick off.

If successful, the workflow will complete with a green checkbox, as seen below:

![image](/images/successful_workflow_run.png)

If it results in a red checkbox, like below, it failed and you will need to click into the workflow to see why it failed.

![image](/images/failed_workflow_run.png)

By design, the following two errors indicates you provided bad data and you will need to check the values you provided and try again.

- The role(s) you provided are not one of the pre-approved roles. If this is the case, the error will look something like this:

![image](/images/invalid_role_error.png)

- The object ID of the service principal you provided could not be found. If this is the case, the error will look something like this:

![image](/images/service_principal_not_found_error.png)

Lastly there is a possibility where one or more of the specified roles are already assigned to the target principal. While the workflow returns as failed, it is likely that any other roles you wanted to assign were successful. The error will look something like this:

![image](/images/role_already_assigned_error.png)

If the error is not any of the above, please contact your DevOps team for assistance.
