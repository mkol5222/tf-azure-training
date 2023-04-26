
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

### Login to Check Point VM using SSH

```powershell
# assume Powershell
terraform output -raw cp_login_cmd | iex
# cliboard contains password, just paste it (e.g mouse right click)

```

### Use AKS cluster with kubectl

```powershell
az aks get-credentials -g tf-azure-training-rg -n aks1
kubectl get nodes
```

### Disable hide NAT for AKS Pods
```powershell
# assume Powershell

@'
apiVersion: v1
kind: ConfigMap
metadata:
  name: azure-ip-masq-agent-config
  namespace: kube-system
  labels:
    component: ip-masq-agent
    kubernetes.io/cluster-service: "true"
    addonmanager.kubernetes.io/mode: EnsureExists
data:
  ip-masq-agent: |-
    nonMasqueradeCIDRs:
      - 0.0.0.0/0
    masqLinkLocal: true
'@ |  kubectl -n kube-system apply -f -

```

### Some Azure demo workload
```powershell
kubectl create ns demo
kubectl -n demo create deploy webka1 --image nginx --replicas 3

kubectl -n demo get pods -o wide --show-labels

# some traffice
kubectl -n demo get pods -o name | % { kubectl -n demo exec -it $_ -- curl ip.iol.cz/ip/ -s -m 2 }
```

### Wait for CP Management to become available
Login using SSH
```powershell
# VM diagnostics in Azure (serial console)

# before FTCW finished
tail -f /var/log/cloud_config.log
# after reboot check for server readiness
watch -d api status
```

### Enable CP Management API Server
```
# add user api_user

# enable API server
mgmt_cli -r true set api-settings accepted-api-calls-from "All IP addresses" --domain 'System Data' --format json
api restart
api status
```