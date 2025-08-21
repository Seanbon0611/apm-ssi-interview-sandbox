
CONTAINER_NAME=java-app
namespace ?= default
JAVA_POD_NAME=$(shell kubectl get pods --all-namespaces -l app=java-app -o jsonpath="{.items[0].metadata.name}")
.PHONY: build load apply clean exec tunnel describe logs

# App commands
build:
	docker build -t java-app:latest ./java-app/.

load:
	minikube image load java-app:latest

apply:
	kubectl apply -n $(namespace) -f java_deployment.yaml

clean:
	kubectl delete -n $(namespace) -f java_deployment.yaml

deploy: build load apply

# Agent commands
agent:
	helm install datadog-agent -f values.yaml datadog/datadog

uninstall:
	helm uninstall datadog-agent

# Commands for interacting with the application pods
exec:
	kubectl exec -it $(JAVA_POD_NAME) -c $(CONTAINER_NAME) -- /bin/bash

tunnel:
	kubectl port-forward -n $(namespace) $(JAVA_POD_NAME) 8080:8080

describe:
	kubectl describe pod $(JAVA_POD_NAME) -n $(namespace)

logs:
	kubectl logs -n $(namespace)  $(JAVA_POD_NAME) -c $(CONTAINER_NAME)
