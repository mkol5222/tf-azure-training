
locals {
    # cat ~/.kube/config | yq . | jq -r '.clusters[]|select(.name=="aks1")|.cluster.server'
    k8s_server = "https://aks1-xxxxxxx.hcp.westeurope.azmk8s.io:443"
    # cat ~/.kube/config | yq . | jq -r '.clusters[]|select(.name=="aks1") | .cluster["certificate-authority-data"]'
    k8s_ca_cert = "LS0tLS1CRUdJTiBDRVJUSUZxxx"
    # SA token
    #  kubectl get secret/cloudguard-controller -o json | jq -r .data.token | base64 -d ; echo;
    k8s_token = "eyJhbGciOiJSUzI1NiIsImtpZCI6Ijhwyyy"

}

resource "checkpoint_management_kubernetes_data_center_server" "testKubernetes" {
  name       = "MyKubernetes"
  hostname   =  local.k8s_server
  token_file = base64encode( local.k8s_token )
  ca_certificate = base64encode( local.k8s_ca_cert )
  unsafe_auto_accept = true
}