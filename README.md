# 🚀 AKS Deployment with Terraform + GitHub Actions

This repository provisions an **Azure Kubernetes Service (AKS)** cluster using **Terraform**, and deploys it automatically via **GitHub Actions**.

---

# 🧭 What This Project Does

This project:

1. Creates an Azure Resource Group
2. Provisions an AKS cluster inside it
3. Configures a node pool for workloads
4. Uses GitHub Actions to automate deployment
5. Authenticates securely to Azure using a Service Principal

---

# 🏗️ Architecture Overview

```
GitHub Repo
   │
   ├── GitHub Actions Workflow
   │       │
   │       ▼
   │   Azure Login (Service Principal)
   │       │
   │       ▼
   │   Terraform
   │       │
   │       ▼
   └── Azure Resources
           ├── Resource Group
           └── AKS Cluster (Node Pool)
```

---

# 📁 Repository Structure

```
aks-terraform/
├── .github/workflows/terraform.yml   # CI/CD pipeline
├── main.tf                          # AKS + Resource Group
├── variables.tf                     # Input variables
├── outputs.tf                       # Outputs (kubeconfig, names)
├── provider.tf                      # Azure provider config
├── versions.tf                      # Terraform + provider versions
├── terraform.tfvars                 # Values for variables
└── README.md
```

---

# 🔐 Authentication (GitHub → Azure)

This project uses a **Service Principal stored as a GitHub Secret**.

## Step 1: Create Service Principal

```bash
az ad sp create-for-rbac \
  --name "github-actions-aks" \
  --role Contributor \
  --scopes /subscriptions/<SUBSCRIPTION_ID> \
  --sdk-auth
```

---

## Step 2: Add GitHub Secret

Go to:

**Repo → Settings → Secrets and variables → Actions**

Create:

* **Name:** `AZURE_CREDENTIALS`
* **Value:** Paste the full JSON output

---

# ⚙️ CI/CD Workflow

The pipeline is defined in:

```
.github/workflows/terraform.yml
```

## What happens on each run:

### 🔹 On Pull Request

* `terraform init`
* `terraform validate`
* `terraform plan`

### 🔹 On Push to `main`

* All of the above +
* `terraform apply` (deploys infrastructure)

---

# 🚀 Deployment Steps (What Actually Happens)

When you push code:

### 1. GitHub Actions starts

* Runs on Ubuntu runner

### 2. Azure Login

* Uses `AZURE_CREDENTIALS`
* Authenticates via Service Principal

### 3. Terraform Init

* Downloads Azure provider

### 4. Terraform Validate

* Checks syntax and configuration

### 5. Terraform Plan

* Calculates what resources will be created

### 6. Terraform Apply

* Creates:

  * Resource Group
  * AKS Cluster
  * Node Pool

---

# 📦 Resources Created

### 1. Resource Group

* Name: `rg-aks-demo`
* Location: Defined in `terraform.tfvars`

### 2. AKS Cluster

* Name: `aks-demo-cluster`
* DNS Prefix: `aksdemo`

### 3. Node Pool

* VM Size: `Standard_D2s_v3` (or updated value)
* Node Count: configurable

---

# 📤 Outputs

Terraform generates:

### 🔹 Cluster Name

```bash
terraform output aks_cluster_name
```

### 🔹 Resource Group

```bash
terraform output resource_group_name
```

### 🔹 Kubeconfig (IMPORTANT)

```bash
terraform output -raw kube_config > kubeconfig
```

---

# 🔗 Connect to the Cluster

```bash
export KUBECONFIG=./kubeconfig
kubectl get nodes
```

You should see your AKS nodes running ✅

---

# ⚠️ Known Considerations

### 1. vCPU Quotas

AKS may fail if:

* Region quota is too low
* VM size requires more vCPUs than available

Fix:

* Use smaller VM (`Standard_B2s`)
* Reduce node count
* Request quota increase

---

### 2. Terraform State (Important)

If no remote backend is configured:

* GitHub Actions does NOT persist state
* Resources may already exist but Terraform won’t know

👉 Recommended: Use Azure Storage backend (future improvement)

---

# 🧹 Cleanup

To destroy resources:

```bash
terraform destroy
```

Or delete the resource group:

```bash
az group delete --name rg-aks-demo --yes
```

---

# ✅ Final Outcome

After successful execution, you have:

* ✔️ A running AKS cluster in Azure
* ✔️ Fully automated deployment via GitHub Actions
* ✔️ Secure authentication using GitHub Secrets
* ✔️ Terraform-managed infrastructure

---

# 🚀 Next Steps (Recommended)

Enhance this project with:

* Remote Terraform state (Azure Storage)
* Azure Container Registry (ACR)
* Deploy an app to AKS (Helm or kubectl)
* Ingress Controller (NGINX)
* OIDC authentication (no secrets)

---

# 🎯 Summary

This project demonstrates a complete **Infrastructure-as-Code + CI/CD pipeline**:

* Terraform → defines infrastructure
* GitHub Actions → automates deployment
* Azure → hosts Kubernetes

You now have a reproducible, automated AKS deployment pipeline 🚀
