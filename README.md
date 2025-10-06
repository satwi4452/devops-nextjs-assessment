# DevOps Internship Assessment - Next.js App Deployment

This repository showcases the containerization and deployment of a Next.js application using Docker, GitHub Actions for CI/CD, and Kubernetes (Minikube) for orchestration.

## Table of Contents
- [Project Objective](#project-objective)
- [Requirements Met](#requirements-met)
- [Application Structure](#application-structure)
- [Prerequisites (Setup Instructions)](#prerequisites-setup-instructions)
- [Local Development and Testing](#local-development-and-testing)
- [CI/CD with GitHub Actions](#cicd-with-github-actions)
- [Deployment to Minikube](#deployment-to-minikube)
- [Accessing the Deployed Application](#accessing-the-deployed-application)
- [GitHub Container Registry (GHCR) Image](#github-container-registry-ghcr-image)
- [Evaluation Focus Points](#evaluation-focus-points)

---

## Project Objective

The primary objective of this assessment is to demonstrate proficiency in key DevOps practices:
1.  **Containerization:** Using Docker to package a Next.js application.
2.  **CI/CD Automation:** Implementing a GitHub Actions workflow to automate the build and push of Docker images to GitHub Container Registry (GHCR).
3.  **Orchestration:** Deploying the containerized application to a local Kubernetes cluster (Minikube) using YAML manifests.

## Requirements Met

This project successfully addresses all requirements outlined in the assessment:

*   **Next.js Application:** A simple Next.js starter application is provided.
*   **Dockerfile:** An optimized `Dockerfile` for containerizing the Next.js application, adhering to best practices (e.g., multi-stage build, `.dockerignore`).
*   **GitHub Actions Workflow:** A `.github/workflows/ci-cd.yaml` file automates the Docker image build and push to GHCR upon pushes to the `main` branch, utilizing proper image tagging.
*   **Kubernetes Manifests:** The `k8s/` directory contains `deployment.yaml` (with replicas and resource requests/limits) and `service.yaml` (configured as NodePort to expose the application).
*   **Comprehensive Documentation:** This `README.md` provides detailed setup, local run, deployment instructions, and access methods.

## Application Structure

├── .github/
│ └── workflows/
│ └── ci-cd.yaml # GitHub Actions workflow definition
├── k8s/
│ ├── deployment.yaml # Kubernetes Deployment manifest
│ └── service.yaml # Kubernetes Service manifest (NodePort)
├── public/ # Next.js public assets
├── src/ # Next.js source code (or equivalent structure for your app)
├── Dockerfile # Dockerfile for containerization
├── .dockerignore # Files to ignore during Docker image build
├── next.config.js # Next.js configuration
├── package.json # Node.js project dependencies and scripts
├── pnpm-lock.yaml # (or package-lock.json/yarn.lock)
└── README.md # This documentation file
## Prerequisites (Setup Instructions)

To run, build, and deploy this application, you will need the following tools installed on your local machine:

1.  **Git**: For cloning the repository.
    *   [Download & Install Git](https://git-scm.com/downloads)
2.  **Node.js & pnpm (or npm/yarn)**: To run the Next.js app locally (optional, but good for testing).
    *   [Download & Install Node.js](https://nodejs.org/en/download/) (pnpm is installed via npm: `npm install -g pnpm`)
3.  **Docker Desktop**: For building and running Docker images locally.
    *   [Download & Install Docker Desktop](https://www.docker.com/products/docker-desktop/)
4.  **Minikube**: A tool to run a local Kubernetes cluster.
    *   [Install Minikube](https://minikube.sigs.k8s.io/docs/start/) (Ensure you select the correct OS and driver, e.g., Docker driver is common)
5.  **kubectl**: The Kubernetes command-line tool, used to interact with Kubernetes clusters.
    *   [Install kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) (Often installed automatically with Docker Desktop or Minikube, but confirm)

**First Step: Clone the Repository**
Open your terminal or command prompt and run:
```bash
git clone https://github.com/satwi4452/devops-nextjs-assessment.git
cd devops-nextjs-assessment

**Local Development and Testing**
You can run the Next.js application directly or via Docker locally for testing purposes:
1. Run with Node.js (via pnpm/npm/yarn)
This method requires Node.js and pnpm (or npm/yarn) installed.
code
Bash
pnpm install # or npm install or yarn install
pnpm dev     # or npm run dev or yarn dev
The application will be accessible at http://localhost:3000.

This method uses Docker to build and run your image locally without pushing to GHCR.
code
Bash
docker build -t nextjs-app-local .
docker run -p 3000:3000 nextjs-app-local

The application will be accessible at http://localhost:3000.
CI/CD with GitHub Actions
A GitHub Actions workflow (.github/workflows/ci-cd.yaml) is configured to:
Trigger on every push to the main branch.
Build the Docker image for the Next.js application.
Tag the image with latest and the short commit SHA.
Push the tagged images to GitHub Container Registry (GHCR).
You can view the workflow runs in your GitHub repository under the "Actions" tab.
Deployment to Minikube
Follow these steps to deploy the application to your local Minikube cluster:

Deployment to Minikube
Follow these steps to deploy the application to your local Minikube cluster:
Start Minikube:
Make sure Minikube is running with a suitable driver (like Docker).
code
Bash
minikube start --driver=docker # or your chosen driver
If you've run Minikube before, minikube start might be enough.
This command might take a few minutes the first time as it downloads necessary components.
Verify Minikube status:
code
Bash
minikube status
Ensure the Host, Kubelet, and APIServer are all Running.
Apply Kubernetes Manifests:
Navigate to the root of your repository (where the k8s folder is located) in your terminal.
code
Bash
kubectl apply -f k8s/
This command tells Kubernetes to create the Deployment and Service defined in your k8s folder. You should see output indicating that deployment.apps/nextjs-app-deployment created and service/nextjs-app-service created.
Verify Deployment and Pods:
Check if your application's pods are running:
code
Bash
kubectl get deployments
kubectl get pods
Wait until all pods show a Running status (it might take a minute or two for the images to pull and pods to start). You should see nextjs-app-deployment and several nextjs-app- pods.
Verify Service:
Check the status of your service:
code
Bash
kubectl get services
You should see nextjs-app-service with TYPE NodePort and a PORT(S) like 80:30000/TCP.
Accessing the Deployed Application
Once deployed to Minikube and verified:
Get the Service URL:
The easiest way to get the URL for your NodePort service in Minikube is:
code
Bash
minikube service nextjs-app-service --url
This command will output the full URL (e.g., http://192.168.49.2:30000) where your application is accessible.
Open in Browser:
Copy the URL provided by the minikube service command and paste it into your web browser. You should now see your Next.js application running, served from your Minikube cluster!
GitHub Container Registry (GHCR) Image
Your Docker image is automatically built and pushed to GitHub Container Registry (GHCR) by the GitHub Actions workflow whenever you push changes to the main branch.
Your Image URL: ghcr.io/YOUR_GITHUB_USERNAME/YOUR_REPO_NAME:latest
Remember to replace YOUR_GITHUB_USERNAME and YOUR_REPO_NAME with your actual GitHub details.
You can also view your published packages directly on GitHub under your repository's "Packages" section.
Evaluation Focus Points
This project was developed with careful attention to the following evaluation criteria:
Docker optimization: Multi-stage build, .dockerignore for small image size and efficient caching.
GitHub Actions implementation: Automated build, push to GHCR, proper image tagging, and use of secrets for authentication.
Kubernetes configuration quality: Appropriate use of Deployment and Service, defining replicas, resource requests/limits, and using NodePort for Minikube exposure. (Liveness/Readiness probes can be added for more advanced health checks if desired).
Documentation clarity: Comprehensive README.md with clear setup, local run, deployment instructions, and access methods.
code
Code
---

### **Your IMMEDIATE Action Items for `README.md`:**

1.  **Paste the entire content above into your `README.md` file.**
2.  **Find and replace the following placeholders:**
    *   `YOUR_GITHUB_USERNAME`: Replace this with your actual GitHub username.
    *   `YOUR_REPO_NAME`: Replace this with the exact name of your GitHub repository.
    *   **There are three places to update this:**
        *   Under `Prerequisites (Setup Instructions)` -> `git clone` command.
        *   Under `GitHub Container Registry (GHCR) Image` -> `Your Image URL`.
3.  **Review the "Application Structure" section:** Make sure it accurately reflects your project's file and folder layout. If your Next.js app's source is in a different folder name than `src/`, update that line.
4.  **Review the "Local Development and Testing" commands:** Ensure `pnpm install` and `pnpm dev` are correct for your Next.js setup. If you use `npm` or `yarn`, adjust those lines.
5.  **Optional: Health Checks:** In the `Evaluation Focus Points` section, I mentioned "(Liveness/Readiness probes can be added for more advanced health checks if desired)". We purposefully left them out of `deployment.yaml` initially to keep things simple. If you feel comfortable, you can add them back to your `deployment.yaml` in the `containers` section like this:
    ```yaml
        livenessProbe:
          httpGet:
            path: / # or a specific health check endpoint your app might have
            port: 3000
          initialDelaySeconds: 15
          periodSeconds: 20
        readinessProbe:
          httpGet:
            path: /
            port: 3000
          initialDelaySeconds: 5
          periodSeconds: 10
    ```
    This makes your deployment more robust, as Kubernetes will actively check if your app is alive and ready for traffic. If adding this feels like too much right now, don't worry about it; the current `deployment.yaml` will work.

