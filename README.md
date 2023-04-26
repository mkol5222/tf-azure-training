
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


### Login to Ubuntu Machines using SSH

```powershell
# assume Powershell

# make sure if SSH check for config files in ~/.ssh/config.d folder

cat ~/.ssh/config | sls 'config.d'
# Include config.d/*.conf
# if not, add line above to ~/.ssh/config and mkdir ~/.ssh/config.d

# retrieve ubuntu1 and ubuntu2 private SSH keys
terraform output -raw u1_ssh_key > ~/.ssh/ubuntu1.key
terraform output -raw u2_ssh_key > ~/.ssh/ubuntu2.key

# retrieve Ubuntu VM ssh configs for easy access
terraform output -raw u1_ssh_config > ~/.ssh/config.d/ubuntu1.conf
terraform output -raw u2_ssh_config > ~/.ssh/config.d/ubuntu2.conf

# test access VMs
ssh ubuntu1
ssh ubuntu2
```

```