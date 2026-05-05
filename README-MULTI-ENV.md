# 🚀 AKS Multi-Environment Deployment with Terraform + GitHub Actions

This repository (`github-aks-terraform`) provisions Azure Kubernetes Service (AKS) clusters across **dev / test / prod environments** using Terraform and automates deployments using GitHub Actions CI/CD pipelines.

---

# 🧭 What This Project Does

This project provides a complete Infrastructure as Code (IaC) solution for AKS:

- Creates Azure Resource Groups per environment
- Deploys AKS clusters for dev, test, and prod
- Uses reusable Terraform configuration
- Supports multi-environment deployments via tfvars
- Automates CI/CD using GitHub Actions
- Implements safe plan-before-apply workflow (what-if equivalent)

---

# 🏗️ Architecture Overview

Developer  
→ GitHub Repository (github-aks-terraform)  
→ GitHub Actions Workflow  
→ Environment Selection (dev / test / prod)  
→ Terraform Execution  
→ Azure Subscription  
→ Resource Group  
→ AKS Cluster  
→ Node Pool  

---

# 📁 Repository Structure

.github/workflows/
- deploy-aks-tf-multi-env-with-what-if.yml   → Multi-env pipeline with what-if
- deploy-aks-tf-with-what-if.yml            → Single env pipeline
- terraform.yml                             → Basic Terraform pipeline

infra files:
- main.tf                                   → Root Terraform configuration
- provider.tf                               → Azure provider setup
- variables.tf                              → Input variables
- outputs.tf                                → Output values
- versions.tf                               → Terraform & provider versions

Environment files:
- dev.tfvars                                → Dev configuration
- test.tfvars                               → Test configuration
- prod.tfvars                               → Prod configuration

Docs:
- Architecture_Multi-Env_AKS.JPG            → Architecture diagram
- README.md                                 → Main documentation
- README-MULTI-ENV-ARCHITECTURE.md          → Detailed architecture doc

---

# 🔐 Authentication (GitHub → Azure)

This project uses an Azure Service Principal stored in GitHub Secrets.

## Step 1: Create Service Principal

az ad sp create-for-rbac \
  --name "github-actions-aks" \
  --role Contributor \
  --scopes /subscriptions/<SUBSCRIPTION_ID> \
  --sdk-auth

---

## Step 2: Add GitHub Secret

Go to:

Repo → Settings → Secrets and variables → Actions

Add:

AZURE_CREDENTIALS = <JSON OUTPUT FROM ABOVE COMMAND>

---

# ⚙️ CI/CD Pipeline Overview

All pipelines are located under:

.github/workflows/

---

## Pipeline Types

### 1. Multi-Environment Pipeline (Recommended)
File:
deploy-aks-tf-multi-env-with-what-if.yml

Supports:
- dev
- test
- prod
- what-if plan stage
- optional approval for prod

---

### 2. Single Environment Pipeline
File:
deploy-aks-tf-with-what-if.yml

Used for:
- quick deployments
- testing changes

---

### 3. Basic Terraform Pipeline
File:
terraform.yml

Supports:
- init
- validate
- plan
- apply

---

# 🚀 Deployment Flow

When a workflow runs:

## 1️⃣ Trigger
Manual or push-based GitHub Actions trigger

---

## 2️⃣ Environment Selection
User selects:

- dev → uses dev.tfvars
- test → uses test.tfvars
- prod → uses prod.tfvars

---

## 3️⃣ Terraform Init
Initializes:
- Azure provider
- backend configuration

---

## 4️⃣ Terraform Validate
Checks:
- syntax
- variables
- module structure

---

## 5️⃣ Terraform Plan (What-If Equivalent)
Shows:
- resources to create
- resources to update
- resources to delete

✔ No changes applied

---

## 6️⃣ Terraform Apply
Creates infrastructure:

- Resource Group
- AKS Cluster
- Node Pool

---

## 7️⃣ Optional Approval (Prod Only)
Production deployments require manual approval:

Plan → Approval → Apply

---

# 📦 Infrastructure Created

## Resource Groups
- rg-aks-dev
- rg-aks-test
- rg-aks-prod

---

## AKS Clusters
- aks-dev-cluster
- aks-test-cluster
- aks-prod-cluster

---

## Node Pools
- VM size configurable per environment
- Node count configurable via tfvars

---

# 📤 Outputs

Terraform provides:

- AKS Cluster Name
- Resource Group Name
- Kubernetes Config (kubeconfig)

---

# 🔗 Connect to Cluster

export KUBECONFIG=./kubeconfig  
kubectl get nodes  

---

# ⚠️ Known Issues

## 1. VM Quota Limits
AKS deployment may fail if:
- vCPU quota is insufficient
- VM size not available in region

Fix:
- Use smaller VM size
- Reduce node count
- Request quota increase

---

## 2. Terraform State
If no remote backend is configured:
- state is not persisted between runs

Recommended:
- Use Azure Storage backend

---

## 3. Region Availability
Ensure selected region supports:
- AKS
- VM SKU

---

# 🧹 Cleanup

Destroy infrastructure:

terraform destroy -var-file=dev.tfvars

OR

az group delete --name rg-aks-dev --yes

---

# 🧠 Key Design Principles

- Infrastructure as Code (Terraform)
- Modular architecture (reusable configuration)
- Environment isolation (dev/test/prod)
- CI/CD automation (GitHub Actions)
- Safe deployment using plan stage
- Secure authentication (no hardcoded secrets)

---

# ✅ Final Outcome

✔ Multi-environment AKS deployment  
✔ Fully automated GitHub Actions CI/CD  
✔ Secure Azure authentication  
✔ Scalable Terraform architecture  
✔ Production-ready DevOps setup  
