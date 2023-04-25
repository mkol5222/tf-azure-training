
### Azure Credentials

Work in [Azure Cloud Shell](https://shell.azure.com/)

```bash
# assume bash

# check used subscription
az account list -o table
# if multiple, set default
az account set --subscription YOUR-SUBSCRIPTION-ID
# check if active
az account list -o table
```

We may also need to create a service principal for Terraform to use. This is a user with a role that allows it to create resources in the subscription. We can create one with the following commands and output parameters in expected format:
```bash
# create and note deployment credentials, where relevant
SUBSCRIPTION_ID=$(az account list -o json | jq -r '.[]|select(.isDefault)|.id')
echo $SUBSCRIPTION_ID
# note credentials for config
AZCRED=$(az ad sp create-for-rbac --role="Owner" --scopes="/subscriptions/$SUBSCRIPTION_ID" -n tf-user -o json)
# echo "$AZCRED" | jq .
CLIENT_ID=$(echo "$AZCRED" | jq -r .appId)
CLIENT_SECRET=$(echo "$AZCRED" | jq -r .password)
TENANT_ID=$(echo "$AZCRED" | jq -r .tenant)
cat << EOF
client_secret = "$CLIENT_SECRET"
client_id = "$CLIENT_ID"
tenant_id = "$TENANT_ID"
subscription_id = "$SUBSCRIPTION_ID"
EOF
```