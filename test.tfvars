resource_group_name = "rg-aks-test-gh"
location            = "Central US"
aks_cluster_name    = "aks-test-cluster-gh"
dns_prefix          = "akstest"
node_count          = 1
//vm_size           = "Standard_L8s_v4" // worked for dev, failed in test for quota
vm_size             = "Standard_D2s_v3"   // allowed + safe choice // worked or all envs and created clusters 
