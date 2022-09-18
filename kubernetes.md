# Kubernetes

## General information

### Benefits

- Scale containers (horizontally, for example: add more pods to a node)
- Update without bringing app down (automate rollback/rollout, zero downtime deployments)
- Self healing (automatically restart container or replace one)
- Not worry about management of containers
- Storage orchestration

### Big picture

- **Master node**: the boss of the operation that manage worker nodes.
- **(Worker) Node**: Can be physical servers or virtual machines.
  - *Kubelet*: Agent installed on the node that makes communication between master and the node possible.
  - *Container runtime*: Run container in the pods.
  - *Kube-Proxy*: Makes sure every pod gets a unique IP. It reflects services.
- **Pod**: There can be multiple pods inside a Node. Inside a pod a container runs.
- **Cluster**: A set of nodes together that run containerized apps.
- **Service**: Enable pods to communicate with the outside world or amongst themselves. It's a deployed group of nodes in a cluster.

![Kubernetes master overview](/images/k8s-overview-master.png)
![Kubernetes cluster overview](/images/k8s-overview-cluster.png)
![Kubernetes cluster overview 2](/images/k8s-overview-cluster-2.png)

#### Pods

Pods run containers and are the environment for them. They organize the different parts of your application (db, cache, APIs, server). They would all have a different Pod, but it is possible to have multiple containers in a Pod. Pods never come back to live.

Pods within a Node have a unique IP address (cluster IP address). They get it when they are getting alive. This cluster IP address is only exposed to the nodes and the pods within a cluster.

##### Probes

A Probe is a diagnostic performerd periodically by the kubelet on a container to check the health of a container.

- Liveness Probe: Check if a Pod is healthy and running as expected. When should a container restart?
- Readiness Probe: Used to determine if a Pod should receive requests. When should a container start receiving traffic?

#### Deployments

Deployments tell Kubernetes how to create or modify instances of the pods that hold a containerized application.
It is a declarative way to manage Pods using a ReplicaSet.
Deployments and ReplicaSets ensure Pods stay running and can be used to scale Pods.

- Supports zero-downtime updates by creating and destroying ReplicaSets
- Provides rollback functionality

![Kubernetes deployments overview](/images/k8s-overview-deployments.png)
![Kubernetes deployments overview 2](/images/k8s-overview-deployments-2.png)

##### ReplicaSet

A ReplicaSet is a declarative way to manage Pods. It is basically a Pod controller. It manages multiple Pods.

- Self healing mechanism
- Ensure requested number of Pods are available.
- Provide fault tolerance
- Can be used to scale Pods.

#### Services

Services abstract Pod IP addresses and load balance between Pods. It relies on labels to associate a Service with a Pod.

![Kubernetes services overview](/images/k8s-overview-services.png)

##### Service Types

- **ClusterIP**: Expose the service on a cluster-internal IP (default). Makes service only reachable within the cluster. Allows Pods to talk to other Pods.
- **NodePort**: Expose the service on each Node's IP at a static port. ClusterIP to which the NodePort services routes is automatically created. An external caller can now call into the IP address with that port.
- **LoadBalancer**: Provision an external IP to act as a load balancer for the service. This sits in front of our different Nodes. NodePort and ClusterIP are automatically created. Useful when combined with a cloud provider's load balancer. The load balancer can load balance to a different worker Node.
- **ExternalName**: Maps a service to a DNS name.

## Kubectl

- `kubectl version`: Check kubernetes version.
- `kubectl cluster-info`: View cluster information.
- `kubectl get all`: Retrieve information about Pods, Deployments, Services and more.
- `kubectl get <type>`: You could use it to list information about pods, deployments or services for example.
- `kubectl get pod <pod-name> -o yaml`: Retrieve information about a pod in YAML.
- `kubectl get deployments --show-labels`: Get deployments and show labels.
- `kubectl get deployments -l app=ngninx`: Get deployments with label nginx.
- `kubectl describe pod <pod-name>`: Retrieve information about a pod and show events.
- `kubectl exec <pod-name> -it sh`: Shell into a pod.
- `kubectl edit -f nginx.pod.yml`: Edit a resource file.
- `kubectl run <pod-name> --image=<image-name>`: Create a Deployment for a Pod.
- `kubectl port-forward <pod-name> <external-port:internal-port>`: Forward a port to allow external access to pod.
- `kubectl port-forward deployment/<deployment-name> <external-port:internal-port>`: Forward a port to allow external access to a deployment.
- `kubectl expose`: Expose a port for Deployment or Pod to localhost.
- `kubectl create -f <filename>`: Create a resource from a file, for example a pod.
- `kubectl create -f <filename> --save-config`: Create a resource from a file, for example a pod and write config to annotation that `apply` uses. Useful for migrating from imperative to declarative config.
- `kubectl create -f file.pod.yml --dry-run --validate=true`: Create a pod from a YML file and validate the YML (runs validate by default). The dry run performs a sort of trial and doesn't effect the cluster.
- `kubectl apply -f ./my1.yaml -f ./my2.yaml`: Create or modify a resource. Move from one state to another.
- `kubectl delete <resource-type> <name-of-resource>`: Deletes a resource.
- `kubectl delete pod <name-of-pod>`: Deletes the pod and will cause kubernetes to make a new instance of the pod.
- `kubectl delete deployment <name-of-deployment>`: Deletes the deployment.
- `kubectl scale deployment <name-of-deployment> --replicas=5`: Scale out the deployments.

## Examples

For more examples of working with YML and Kubernetes go to: <https://github.com/DanWahlin/DockerAndKubernetesCourseCode>.
