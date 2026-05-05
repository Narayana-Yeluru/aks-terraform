## 🚀 AKS Multi-Environment Architecture (Dev / Test / Prod)

---

## 🏗️ Architecture Diagram

<img width="1895" height="2507" alt="image" src="https://github.com/user-attachments/assets/a8f65be3-b87c-4922-af05-e9ffcf9a2b05" />


## 🔄 AKS Deployment Flow (Dev / Test / Prod)

### 1️⃣ Developer Trigger
A developer manually triggers the GitHub Actions workflow and selects an environment:
- dev
- test
- prod

---

### 2️⃣ Environment Selection
The pipeline selects the correct Terraform variables file:
- dev.tfvars → small development cluster
- test.tfvars → staging environment
- prod.tfvars → production environment

👉 Same Terraform code, different configurations

---

### 3️⃣ Terraform Initialization
Terraform initializes backend and providers:
- terraform init

This prepares the working directory for deployment.

---

### 4️⃣ Terraform Validation
Terraform validates the code:
- syntax check
- module validation
- variable validation

👉 Ensures infrastructure code is correct before execution

---

### 5️⃣ Terraform Plan (What-If Equivalent)
Terraform generates an execution plan:
- terraform plan

👉 Shows:
- what resources will be created
- what will be changed
- what will be destroyed

✔ No changes are applied at this stage

---

### 6️⃣ Approval Gate (Optional for Prod)
For production:
- manual approval can be enabled in GitHub Actions

👉 Flow:
Plan → Approval → Apply

---

### 7️⃣ Terraform Apply (Deployment)
If approved, Terraform applies the changes:
- terraform apply

This provisions:
- Azure Resource Group
- AKS Cluster
- Node Pools
- Networking

---

### 8️⃣ AKS Module Execution
The root module calls a reusable AKS module which handles:
- cluster creation
- node pool configuration
- managed identity
- networking setup

---

### 9️⃣ Outputs Generation
After deployment, Terraform outputs:
- kubeconfig (cluster access)
- cluster endpoint
- cluster details

---

## 🧠 Key Idea Summary

- One codebase
- Three environments (dev/test/prod)
- Controlled deployments using plan stage
- Reusable AKS module
- Safe production deployment using approval gate
