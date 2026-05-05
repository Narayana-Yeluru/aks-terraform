## 🚀 AKS Multi-Environment Architecture (Dev / Test / Prod)

## 🏗️ Architecture Diagram

```mermaid
flowchart TD

A[Developer] --> B[GitHub Repository]

B --> C[GitHub Actions Pipeline]

C --> D{Select Environment}

D -->|Dev| E1[dev.tfvars]
D -->|Test| E2[test.tfvars]
D -->|Prod| E3[prod.tfvars]

E1 --> F[Terraform Plan]
E2 --> F
E3 --> F

F --> G[Terraform Root Module]

G --> H[AKS Module (Reusable)]

H --> I[Azure Resource Group]

I --> J[AKS Cluster - Dev]
I --> K[AKS Cluster - Test]
I --> L[AKS Cluster - Prod]

J --> M[System Node Pool]
K --> M
L --> M

J --> N[Outputs: kubeconfig]
K --> N
L --> N

C --> O[Optional Approval Gate for Prod]
O --> L
🔄 Flow Explanation
1️⃣ Developer Trigger

A developer manually triggers GitHub Actions and selects an environment:

dev
test
prod
2️⃣ Environment Selection

The pipeline loads the correct Terraform variables file:

dev.tfvars → development setup
test.tfvars → staging setup
prod.tfvars → production setup

👉 Same code, different configuration

3️⃣ Terraform Plan (What-If Equivalent)

Terraform runs:

init
validate
plan

👉 Shows what will change before deployment
👉 No resources are created at this stage

4️⃣ Root Module Execution

The main.tf calls a reusable AKS module.

👉 This avoids duplication and keeps infrastructure modular

5️⃣ AKS Module Execution

The module provisions:

AKS cluster
Node pools
Managed identity
Networking configuration
6️⃣ Azure Deployment

Resources created in Azure:

Resource Group
AKS cluster (per environment)
Node pools
Networking
7️⃣ Outputs

After deployment:

kubeconfig
cluster endpoint
cluster metadata
8️⃣ Production Safety

For production:

manual approval gate can be enabled

Flow becomes:

Plan → Approval → Apply

🧠 Key Design Principles
Modular Terraform architecture
Environment separation using tfvars
Safe deployment using plan stage
Reusable AKS module
Production-safe deployment workflow
