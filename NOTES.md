
### login to Azure

```bash
az login
# or with specific tenant 
az login --tenant TENANT_ID

# verify
az account list -o table
```

### comment out credentials in ./provider.tf

```bash
code ./provider.tf
```

relevant section should look like:

```terraform
provider "azurerm" {
  features {}

  # client_secret   = var.client_secret
  # client_id       = var.client_id
  # tenant_id       = var.tenant_id
  # subscription_id = var.subscription_id
}
```

### Basic Terraform inputs

```bash
code ./terraform.tfvars
```

with contents - choose your own password
```
# future CP admin
admin_password="Vpn123Vpn123#nok"
# future API user
cp-management-user="api-user"
cp-management-password="Vpn123Vpn123#nok"
# unused SP
subscription_id="xxx"
tenant_id="yyy"
client_id="ccc"
client_secret="ddd"
```

### Lets roll-out basic network

```bash
terraform init
terraform plan -target module.environment
terraform apply -target module.environment
```

### Deploy AKS cluster

```bash
terraform plan -target module.aks1
terraform apply -target module.aks1
```

### Login to cluster and deploy app

```bash
# pay attantion to -g RESOURCEGROUPNAME in case you changed default
az aks get-credentials -g tf-azure-training-rg -n aks1
kubectl get nodes -o wide

# deploy app
kubectl create ns demo
kubectl -n demo create deploy webka1 --image nginx --replicas 3

kubectl -n demo get pods -o wide --show-labels

```

### Make some connections

```bash
# some traffice - once app is up and running
PODS=$(kubectl -n demo get pods -o name); for P in $PODS; do echo "$P"; kubectl -n demo exec -it "$P" -- curl ip.iol.cz/ip/ -s -m 2; echo; done
```

### Deploy standalone CHKP

```bash
terraform plan -target module.standalone-chkp
terraform apply -target module.standalone-chkp

# get public IP to connect with SSH and SmartConsole R81.10
az vm list-ip-addresses -g tf-azure-training-rg -o table

# ssh admin@PUBLIC_IP

# password is
terraform output -raw cp_pass; echo
# login
ssh admin@$(terraform output -raw cp_public_ip)

```



