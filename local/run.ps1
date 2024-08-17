param(
    [Parameter(Mandatory=$true)]
    [String]$subscriptionId,
    [Parameter(Mandatory=$true)]
    [String]$tenantId,
    [Parameter(Mandatory=$true)]
    [String]$targetPrincipalId,
    [Parameter(Mandatory=$true)]
    [String[]]$roles,
    [String]$principalId,
    [String]$principalSecret,
    [switch]$useCachedIdentity
)

if ($useCachedIdentity){
    $account = az account show
}

if (!$account)
{
    if ($principalId){
        if (!$principalSecret){
            $AzCred = Get-Credential -UserName $principalId -Message "Please provide the service principal client secret or path to the client certificate"
            $principalSecret = $AzCred.GetNetworkCredential().Password
        }
        $account = az login --service-principal -u $principalId -p $principalSecret --tenant "$tenantId"
    }else{
        $account = az login --tenant $tenantId
    }
}

if (!$account){
    throw "Unable to authenticate with Azure CLI"
}

az account set --subscription $subscriptionId

$env:ARM_SUBSCRIPTION_ID = "$subscriptionId"
$env:ARM_TENANT_ID = "$tenantId"

$varRoles = 'roles=[\"' + ($roles -join '\",\"') + '\"]'
$vartargetPrincipalId = "principal_object_id=$targetPrincipalId"

terraform init
terraform apply -var $varRoles -var $vartargetPrincipalId -auto-approve -input=false -compact-warnings