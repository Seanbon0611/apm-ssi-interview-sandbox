## Prerequisites
Minikube - If you don't have Minikube, please follow the installation instruction here: https://minikube.sigs.k8s.io/docs/start/?arch=%2Fmacos%2Farm64%2Fstable%2Fbinary+download

Create datadog secret
`kubectl create secret generic datadog-agent --from-literal api-key="<your API key>"`

## Getting Started:
1. Deploy your Agent & cluster Agent:
`helm install datadog -f values.yaml datadog/datadog`

2. Build the docker image from the Dockerfile:
On minikube first run `eval $(minikube -p minikube docker-env)` before trying to build any images