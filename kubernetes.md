# Kubernetes

## General information

### Benefits

- Scale containers (horizontally, for example: add more pods to a node)
- Update without bringing app down (automate rollback/rollout, zero downtime deployments)
- Self healing (automatically restart container or replace one)
- Not worry about management of containers
- Storage orchestration

### Big picture

- **Master Node/Control Plane**: the boss of the operation that manage worker nodes.
  - *api*: It exposes the Kubernetes API. The frontend for the Kubernetes control plane.
  - *etcd*: Key/value store for cluster data.
  - *kube-scheduler*: Selects a node for newly created Pods.
  - *kube-controller-manager*: Component that runs controller processes. Makes changes to move current to desired state.
  - *cloud-controller-manager*: Has cloud-specific logic. Lets you link your cluster into your cloud provider's API.
- **(Worker) Node**: Can be physical servers or virtual machines.
  - *Kubelet*: Agent installed on the node that makes communication between master and the node possible. It makes sure containers are running in a Pod. Can handle multiple Pods.
  - *Container runtime*: Run container in the Pods.
  - *Kube-Proxy*: Makes sure every pod gets a unique IP. It reflects services. It maintains network rules in a Node.
- **Pod**: There can be multiple pods inside a Node. Inside a pod a container runs.
- **Cluster**: A set of nodes together that run containerized apps.
- **Service**: Enable pods to communicate with the outside world or amongst themselves. It's a deployed group of nodes in a cluster.

Cluster overview technical:
![Kubernetes cluster overview 1](/images/k8s-overview-cluster-1.svg)

Cluster overview multiple Pods:
![Kubernetes cluster overview 2](/images/k8s-overview-cluster-2.png)

Cluster overview simple language:
![Kubernetes cluster overview 3](/images/k8s-overview-cluster-3.png)

Cluster overview with services:
![Kubernetes cluster overview 4](/images/k8s-overview-cluster-4.png)

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

You can do multiple deployment strategies:

- Rolling update (replace existing Pods with newer ones)
- Blue/green deployment (have two production environments, do all final testing on one of them and then ultimately switch to that one)
- Canary deployment (similar to rolling update, but instead targets certain users instead of servers)
- Recreate (terminate all Pods and replaces them with the new ones at once)

##### ReplicaSet

A ReplicaSet is a declarative way to manage Pods. It is basically a Pod controller. It manages multiple Pods.

- Self healing mechanism
- Ensure requested number of Pods are available.
- Provide fault tolerance
- Can be used to scale Pods.

#### StatefulSet

A StatefulSet is similar to a Deployment. The key differences are:

- Deployments are used for stateless applications, StatefulSets for stateful applications.
- The pods in a deployment are interchangeable, whereas the pods in a StatefulSet are not.
- Deployments require a service to enable interaction with pods, while a headless service handles the pods’ network ID in StatefulSets.
- In a deployment, the replicas all share a volume and PVC, while in a StatefulSet each pod has its own volume and PVC.

#### Services

Services abstract Pod IP addresses and load balance between Pods. It relies on labels to associate a Service with a Pod.

![Kubernetes services overview](/images/k8s-overview-services.png)

##### Service Types

- **ClusterIP**: Expose the service on a cluster-internal IP (default). Makes service only reachable within the cluster. Allows Pods to talk to other Pods. No external access.
- **NodePort**: Expose the service on each Node's IP at a static port. ClusterIP to which the NodePort services routes is automatically created. An external caller can now call into the IP address with that port. Opens specific port on all Nodes.
- **LoadBalancer**: Provision an external IP to act as a load balancer for the service. This sits in front of our different Nodes. NodePort and ClusterIP are automatically created. Useful when combined with a cloud provider's load balancer. The load balancer can load balance to a different worker Node. Useful when you want to directly expose a service. Uses an IP for every service. Balanceren van de load naar worker nodes.
- **ExternalName**: Maps a service to a DNS name.

#### Ingress

Ingress sits in front of multiple services and act as a “smart router” or entrypoint into your cluster. This way you can expose services to external world.

![Kubernetes overview Ingress](/images/k8s-overview-ingress.png)

An Ingress controller is responsible for fulfilling the Ingress, usually with a load balancer. You must have an Ingress controller to satisfy an Ingress. Only creating an Ingress resource has no effect. There are many Ingress controllers, the most used one is [nginx](https://kubernetes.github.io/ingress-nginx/deploy/).

### Storage options

#### Volumes

A volume references a storage location. A Pod can have mulitple volumes to store data.

There are multiple volume types:

- **emptyDir**: Empty directory for data that pods need during their lifetime. Goes away when Pod goes down.
- **hostPath**: Pod mounts to a worker Node's filesystem. You lose the volume when Node goes down.
- **nfs**: When a Pod is mounting to a NFS volume somewhere on the network.
- **persistentVolumeClaim**: A request for a Persistent Volume (PV) storage unit.
- **configMap**: For configuration files (key/value pairs).
- **cloud**: Cluster-wide storage.

##### PersistentVolume

A PersistentVolume (PV) is a cluster-wide storage unit with a lifecycle independent from a Pod provisioned by an administrator. It relies on network attached storage (NAS). This can be cloud or a local network. It stays available to a Pod even if this storage gets rescheduled to another Node because the file system is mounted to the cluster.

![Kubernetes overview PersistentVolume](/images/k8s-overview-persistentvolume.png)

##### StorageClasses

A StorageClass provides a way for administrators to describe the "classes" of storage they offer. It acts as a kind of template and supports dynamic provisioning of PersistentVolumes.

![Kubernetes overview StorageClasses](/images/k8s-overview-storageclasses.png)

#### ConfigMap

Store configuration information and provide it to containers. ConfigMaps basically provide key/value pairs. ConfigMaps can be accessed from a Pod by using env variables or ConfigMap volumes. Using volumes will automatically update files referenced by the volumes when the ConfigMap changes.

This can be done in several ways:

- ConfigMap manifest (YML file): `kubectl create -f <file>`
- .config file: `kubectl create configmap <cm-name> --from-file=<file>`
- .env file: `kubectl create configmap <cm-name> --from-env-file=<file>`

#### Secret

A Secret is an object that contains sensitive data (password, token, key). This avoid storing secrets in container images. Secrets are only available to Nodes that have a Pod needing that Secret.

- `kubectl create secret generic my-secret --from-literal=pwd=password`: Create secret and store in Kubernetes.
- `kubectl create secret generic my-secret --from-file=ss-publickey=<path-to-file>`: Create secret from file and store in Kubernetes.
- `kubectl create secret tls tls-secret --cert=<path-to-cert> --key=<path-to-key>`: Create secret from a key pair.

## Kubectl

- `kubectl version`: Check kubernetes version.
- `kubectl cluster-info`: View cluster information.
- `kubectl get all`: Retrieve information about Pods, Deployments, Services and more.
- `kubectl get <type>`: You could use it to list information about pods, deployments or services for example.
- `kubectl get pod <pod-name> -o yaml`: Retrieve information about a pod in YAML.
- `kubectl get deployments --show-labels`: Get deployments and show labels.
- `kubectl get deployments -l app=ngninx`: Get deployments with label nginx.
- `kubectl describe pod <pod-name>`: Retrieve information about a pod and show events and volumes.
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
- `kubectl logs <pod-name> -c <container-name>`: View logs of specific container in Pod.

### Kubernetes Dashboard

Create dashboard:

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.6.1/aio/deploy/recommended.yaml
```

Create admin user:

```bash
kubectl apply -f dashboard-adminuser.yaml
```

Create token to login to dashboard:

```bash
kubectl -n kubernetes-dashboard create token admin-user
```

Make dashboard visible in browser:

```bash
kubectl proxy
```

## Examples

For more examples of working with YML and Kubernetes go to: <https://github.com/DanWahlin/DockerAndKubernetesCourseCode>.
