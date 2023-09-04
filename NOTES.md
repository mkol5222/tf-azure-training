
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

with contents
```
# future CP admin
admin_password="vpn123vpn123"
# future API user
cp-management-user="api-user"
cp-management-password="vpn123vpn123#nok"
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
```