## Prerequisites

Before getting started, ensure you have the following tools installed:

### Required Tools:

1. **Kubernetes** - Container orchestration platform
   - Installation guide: https://kubernetes.io/docs/setup/

2. **Minikube** - Local Kubernetes cluster for development
   - Installation guide: https://minikube.sigs.k8s.io/docs/start/

3. **Helm** - Kubernetes package manager
   - Installation guide: https://helm.sh/docs/intro/install/

4. **Docker** - Container platform for building applications
   - Installation guide: https://docs.docker.com/get-docker/


### Setup Steps:

Create datadog secret
`kubectl create secret generic datadog-agent --from-literal api-key="<your API key>"`

## Getting Started:
1. Deploy your Agent & cluster Agent:
`helm install datadog -f values.yaml datadog/datadog`

2. Build the docker image from the Dockerfile:
On minikube, first run `eval $(minikube -p minikube docker-env)` before building any images. This command configures your shell to use the Docker daemon inside the Minikube VM, so that any images you build are available directly to your Minikube Kubernetes cluster.

3. Building the application images:
We have two application images that need to be built. From the root directory of the project, run the following commands:

**For the Python application:**
```bash
docker build -t python-app:latest ./python-app
```

**For the Java application:**
```bash
docker build -t java-app:latest ./java-app
```

4. Running the applications:
To run the application run the following commands:

**For the Python application:**
```bash
kubectl apply -f python_deployment.yaml
```

**For the Java application:**
```bash
kubectl apply -f java_deployment.yaml
```