# Steps in Azure Shell

### Open Azure Shell and get repo

Open [Azure Shell](https://shell.azure.com/)

```bash
# make sure expected subscription is active
az account list -o table
# clone repo
cd; mkdir w; cd w
git clone https://github.com/mkol5222/tf-azure-training
cd tf-azure-training
```

### Review inputs

```bash
# copy sample and edit
cp terraform.tfvars.sample terraform.tfvars
code terraform.tfvars
```

### Deploy

```bash
# init and build plan
terraform init
terraform plan -out my.tfplan
# read the plan
terraform show my.tfplan
# execute plan
terraform apply my.tfplan
```


### Login to Ubuntu Machines using SSH

```powershell
# make sure if SSH check for config files in ~/.ssh/config.d folder

cat ~/.ssh/config | grep 'config.d'
# Include config.d/*.conf
# if not, add line above to ~/.ssh/config and mkdir ~/.ssh/config.d

# retrieve ubuntu1 and ubuntu2 private SSH keys
terraform output -raw u1_ssh_key > ~/.ssh/ubuntu1.key
terraform output -raw u2_ssh_key > ~/.ssh/ubuntu2.key
# might need to review permissions in Linux/bash
chmod 400 ~/.ssh/ubuntu1.key
chmod 400 ~/.ssh/ubuntu2.key

# retrieve Ubuntu VM ssh configs for easy access
terraform output -raw u1_ssh_config > ~/.ssh/config.d/ubuntu1.conf
terraform output -raw u2_ssh_config > ~/.ssh/config.d/ubuntu2.conf

# test access VMs
ssh ubuntu1
ssh ubuntu2
```

### Login to Check Point VM using SSH

```bash
# password is
terraform output -raw cp_pass; echo
# login
ssh admin@$(terraform output -raw cp_public_ip)
```

### Wait for CP Management to become available

```bash
# while FTW is running, monitor VM initialization
tail -f /var/log/cloud_config.log
# after reboot check for server readiness - watch for "API readiness test SUCCESSFUL"
watch -d api status
```

### MEANWHILE Deploy app on Kubernetes cluster

```bash
# pay attantion to -g RESOURCEGROUPNAME in case you changed default
az aks get-credentials -g tf-azure-training-rg -n aks1
kubectl get nodes -o wide
# deploy app
kubectl create ns demo
kubectl -n demo create deploy webka1 --image nginx --replicas 3

kubectl -n demo get pods -o wide --show-labels

# some traffice
PODS=$(kubectl -n demo get pods -o name); for P in $PODS; do echo "$P"; kubectl -n demo exec -it "$P" -- curl ip.iol.cz/ip/ -s -m 2; echo; done
```

### Once CP Management is ready

Login with SmartConsole and create api_user (yes, this can be automated too in VM cloud init):
- Manage & Settings > Permissions & Administrators: add new api_user with your password
- make sure to uncheck "User must change password on next login"
- permission profile SuperUser

- Manage & Settings > Blades: Management API > Advanced Settings > Enable Management API
- Accept API calls from: all IP addresses

- Publis hchanges.
- Remember to run `api restart` on management server!

Review terrafor.tfvars with your new API user credentials:
```bash
cp-management-user     = "api_user"         
cp-management-password = "M3VePeEn123"  
```

### Make policy with automation

Uncomment module cp-policy in main.tf and apply:
```bash
# edit and save
code main.tf

# TODO: I had to create permissive FW policy to allow API server access and install policy first! Ask during the training.

# if doubts - on Management
api restart
api status 
# and look for
# Accessibility: Require all granted

# apply changes
terraform init
terraform apply -target module.cp-policy

# publish session
terraform apply -target module.cp-policy -var publish=true -auto-approve
# install policy
terraform apply -target module.cp-policy -var install=true -auto-approve
```


### Route traffic throuh Check Point

```bash
# modify terraform.tfvars with route_through_firewall = true
code terraform.tfvars

# apply change
terraform apply -target module.environment
```

### Make some traffice from Ubuntu and AKS

```bash
PODS=$(kubectl -n demo get pods -o name); for P in $PODS; do echo "$P"; kubectl -n demo exec -it "$P" -- curl ip.iol.cz/ip/ -s -m 2; echo; done
```

### Disable NAT for traffice from Pods

```bash
kubectl apply -f - <<EOF
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
EOF
```

Now wait bit and try traffic again and check FW logs:

```bash
PODS=$(kubectl -n demo get pods -o name); for P in $PODS; do echo "$P"; kubectl -n demo exec -it "$P" -- curl ip.iol.cz/ip/ -s -m 2; echo; done

# IPs for reference
kubectl -n demo get pods -o wide --show-labels

kubectl get nodes -o wide
```

### Cleanup

To avoid cloud costs, destroy the environment:
```bash
terraform apply -target module.environment -var route_through_firewall=false -auto-approve

terraform destroy -target module.cp-policy
terraform destroy 
```