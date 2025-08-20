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
We have one application image that need to be built. From the root directory of the project, run the following command:

**For the Java application:**
```bash
docker build -t java-app:latest ./java-app
```

4. Running the applications:
To deploy the application to your Kubernetes cluster, run the following command:

**For the Java application:**
```bash
kubectl apply -f java_deployment.yaml
```

5. Generating traffic:
To generate traffic and test the application, first retrieve the pod name and then execute a curl request:

```bash
# Get the pod name
kubectl get pods

# Generate traffic (replace <pod_name> with the actual pod name from the previous command)
kubectl exec -it <pod_name> -- curl localhost:8080
```

### Makefile Commands
| Command          | Description                                                               |
| ---------------- | ------------------------------------------------------------------------- |
| `make build`     | Build the Docker image for the Java application.                          |
| `make load`      | Load the built Docker image into the local Minikube cluster.              |
| `make apply`     | Deploy the application to Kubernetes (requires `namespace`).              |
| `make clean`     | Delete the application deployment from Kubernetes (requires `namespace`). |
| `make deploy`    | Run build → load → apply in one step.                                     |
| `make agent`     | Install the Datadog Agent using Helm and `values.yaml`.                   |
| `make uninstall` | Uninstall the Datadog Agent from the cluster.                             |
| `make exec`      | Open a bash shell inside the Java application container.                  |
| `make tunnel`    | Forward local port 8080 to the application pod (requires `namespace`).    |
| `make describe`  | Show detailed information about the Java application pod.                 |
| `make logs`      | Stream logs from the application container.                               |

*Note:* namespace can be specified by passing in a namespace parameter. Ex -  `make deploy namespace=value`