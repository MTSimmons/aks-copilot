# Azure Kubernetes Service (AKS) with OpenAI - Demo Environment

This repository contains a demonstration environment for deploying OpenAI services on Azure Kubernetes Service (AKS).

## Repository Structure

```
├── terraform/    # Infrastructure as Code for AKS and Azure resources
├── aks/         # Kubernetes manifests and deployment configurations
└── app/         # Application source code and Docker configuration
```

## Overview

This project demonstrates how to:
- Deploy an AKS cluster using Terraform
- Configure Azure OpenAI services
- Deploy a Flask application that utilizes OpenAI capabilities
- Set up proper Kubernetes resources and configurations

## Prerequisites

- Azure subscription
- Azure CLI installed and configured
- Terraform CLI (>= 1.0.0)
- kubectl configured
- Docker installed
- Python 3.11 or higher
- Access to Azure OpenAI service

## Getting Started

### 1. Infrastructure Deployment

```bash
# Initialize Terraform
cd terraform
terraform init

# Review the deployment plan
terraform plan -var-file="copilot.tfvars" -out="plan.out"

# Apply the infrastructure
terraform apply "plan.out"
```

### 2. Configure AKS Access

```bash
# Get AKS credentials
az aks get-credentials --resource-group rg-copilot --name aks-copilot --overwrite-existing

# Verify cluster access
kubectl get nodes
```

### 3. Application Deployment

#### Setting up Environment Variables
1. Navigate to the `app` directory
2. Copy `.env.example` to `.env`
3. Update with your Azure OpenAI credentials:
   ```properties
   AZURE_INFERENCE_CREDENTIAL=your-credential
   AZURE_OPENAI_ENDPOINT=your-endpoint
   AZURE_OPENAI_DEPLOYMENT=your-deployment-name
   ```

#### Building and Pushing the Docker Image
```bash
cd app
docker build -t yourusername/flask-openai-app:latest .
docker push yourusername/flask-openai-app:latest
```

#### Creating Kubernetes Secrets
1. Convert your secrets to base64:
   ```powershell
   [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("your-secret-value"))
   ```
2. Create `aks/secrets.yaml` using the template in `aks/secrets.example.yaml`
3. Apply the secrets:
   ```bash
   kubectl apply -f aks/secrets.yaml
   ```

#### Deploying to AKS
```bash
# Apply Kubernetes manifests
kubectl apply -f aks/deployment.yaml
kubectl apply -f aks/service.yaml

# Verify deployment
kubectl get pods
kubectl get services
```

### 4. Accessing the Application

1. Get the external IP:
   ```bash
   kubectl get service flask-openai-app
   ```
2. Open your browser and navigate to `http://<external-ip>`

## Configuration Reference

### Terraform Variables
Key variables in `terraform/copilot.tfvars`:
- `resource_group_name`: Name of the Azure resource group
- `cluster_name`: Name of the AKS cluster
- `default_node_count`: Number of nodes in the default pool
- `default_node_pool_vm_size`: VM size for nodes

### Kubernetes Resources
- Deployment: 2 replicas with resource limits
- Service: LoadBalancer type exposing port 80
- Secrets: Contains Azure OpenAI credentials

## Troubleshooting

### Common Issues
1. **Forbidden Access to AKS**
   ```bash
   az aks get-credentials --resource-group rg-copilot --name aks-copilot --overwrite-existing
   ```

2. **Pod Startup Issues**
   ```bash
   kubectl describe pod <pod-name>
   kubectl logs <pod-name>
   ```

3. **Secret Issues**
   - Verify secrets are created: `kubectl get secrets`
   - Check pod environment: `kubectl exec <pod-name> -- env`

## Security Notes

- Never commit `.env` or `secrets.yaml` files to version control
- Rotate Azure OpenAI credentials periodically
- Consider using Azure Key Vault for production deployments

## Contributing

1. Fork the repository
2. Create a feature branch
3. Submit a pull request

## License

[MIT](LICENSE)