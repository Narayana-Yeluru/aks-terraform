# AKS Terraform Deployment with GitHub Actions

This repo provisions an Azure Kubernetes Service (AKS) cluster using Terraform and deploys it via GitHub Actions.

---

## 🚀 Prerequisites

- Azure CLI
- Terraform
- GitHub repo

---

## 🔐 Setup Azure Credentials

Run:

```bash
az ad sp create-for-rbac \
  --name "github-actions-aks" \
  --role Contributor \
  --scopes /subscriptions/<SUBSCRIPTION_ID> \
  --sdk-auth
