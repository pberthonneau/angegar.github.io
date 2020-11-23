# Kubernetes cluster administration

## How many cluster

The following question will help you to design your Kubernetes environment

- Should you run all application instances on a single cluster?
- Or should you have a separate cluster for each application instance?
- Or should you use a combination of the above?

### Different approaches:

- Large shared cluster: one cluster hosting all the environments and all the applications
- Cluster per environment: One cluster per environments for all your applications
- Cluster per application: One cluster hosting all the environments for one application
- Small single-user clusters: One cluster per application per environment

### Pros and cons of various approaches:

![how-many-clusters](https://learnk8s.io/a/eb8d3a97d16f6c490c23fa25f20c7c0f.svg){target=_blank}

!!! info
    We can improve the resilience of the first two solutions with a multi cloud cluster

!!! info "references"
    - [learnk8s.io](https://learnk8s.io/how-many-clusters)

## Multi cloud solution

### Use cases

- service spike
- disaster recovery
- active active

!!! warning "Drawback"
    - Each cloud provider has its own set of API, making multi-cloud solutions hard to architect and to maintain
    - IaaS tools such as Terraform have not solved this issue

### Kubernetes 

- Standardized application delivery
- Decoupled from the underlying cloud
- Kubernetes API is a solid foundation for multi-cloud and hybrid cloud
- Exemple [KubeCDN](https://blog.insightdatascience.com/how-to-build-your-own-cdn-with-kubernetes-5cab00d5c258)

!!! info "Resources"
    - [A Multi-Cloud and Multi-Cluster Architecture with Kubernetes](https://medium.com/datadriveninvestor/a-multi-cloud-and-multi-cluster-architecture-with-kubernetes-cb3abe554948){target=_blank}

## Topology

### Stacked etcd

- etcd is stacked on top of the cluster
- Simpler to set up than a cluster with external etcd nodes, and simpler to manage for replication
- etcd as well as kube-controller-manager and kube-scheduler communicate only with the kube-apiserver of the hosting node
- This is the default topology in kubeadm

!!! warning "Drawback"
    - Loosing one control plane host implies to also loose a etcd member thus the cluster data storage (cluster memory) is impacted

![](https://d33wubrfki0l68.cloudfront.net/d1411cded83856552f37911eb4522d9887ca4e83/b94b2/images/kubeadm/kubeadm-ha-topology-stacked-etcd.svg)

### External etcd

- etcd run in hosts separated from the Kubernetes cluster ones
- kube-controller-manager and kube-scheduler communicate only with the kube-apiserver of the hosting node
- loosing a control plane will not impact the cluster data storage

!!! warning "Drawback"
    - It is more expensive as you need at least 3 more hosts for the etcd cluster

![](https://d33wubrfki0l68.cloudfront.net/ad49fffce42d5a35ae0d0cc1186b97209d86b99c/5a6ae/images/kubeadm/kubeadm-ha-topology-external-etcd.svg)

!!! info "references"
    - [ha-topology](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/ha-topology/)

## Deployments

They are a lot of ways to deploy and maintain a Kubernetes cluster. I will just list some of its to give you a brief overview.

### Local solutions

- [Minikube](https://minikube.sigs.k8s.io/docs/start/){target=_blank}
- [Docker Desktop](https://www.docker.com/products/docker-desktop){target=_blank}
- [MicroK8s](https://microk8s.io/){target=_blank}
- [k3s](https://k3s.io/){target=_blank}

### Managed solutions

- Amazon EKS
- Azure AKS
- DigitalOcean Kubernetes
- Kubermatic
- OpenShift Online

### Bare metal

- CoreOS
- Docker Enterprise
- OpenShift Container Platform
- Kubespray

!!! info "References"
    You will find a huge list of ways to spin up a Kubernetes stack [here](https://kubernetes.io/fr/docs/setup/pick-right-solution/){target=_blank}

## Management / deployment tools

- [kubectl](https://github.com/kubernetes/kubectl){target=_blank}: command line tool lets you control Kubernetes clusters
- [Kops](https://github.com/kubernetes/kops){target=_blank}: Deploy the infrastructure as well as Kubernetes. Currently support AWS, GCE, OpenStack(beta), VMWare vsphere(alpha)
- [kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/){target=_blank}: Deploy Kubernetes on an existing set of servers
- [kubespray](https://github.com/kubernetes-sigs/kubespray){target=_blank}: Deploy kubernetes on an existing infrastructure. It comes with contributions to spin the infrastructure on multiple cloud provider.

## Cluster resources

Even if Kubernetes is built to be highly scalable you have to correctly size the worker nodes to host your workload. To increase the control of the resource usage you can use resource request, limit and quota.

### Default resources

You can configure default CPU and Memory used by pods. If a pod does not specify the required resources then the default values will be configured at the pod creation.

### CPU and memory management

To better control the amount of memory and CPU used by a user (multi tenancy) or by an application, you can configure a [limitation per namespace](https://kubernetes.io/docs/tasks/administer-cluster/manage-resources/memory-default-namespace/){target=_blank}. Like a pod, a namespace can be configured to request a certain amount of resources and burst until it reaches a limit.

### Number of pods

To ensure the available namespace resources will not be spread across too many pods, you can limit the number of pods per namespace.

!!! info "References"
    [kubernetes documentation](https://kubernetes.io/docs/tasks/administer-cluster/manage-resources/cpu-default-namespace/){target=_blank}

## Network Policy

Network policy providers are used to control the traffic flow at the IP or port level (OSI layer 3 or 4). In other words you can configure a kind of firewall to authorize traffic flowing between:

- A pod and other pods
- A pod and namespaces
- A pod and particular IPs

### Providers

- Calico
- Cilium
- Kube-router
- Romana
- Weave net


## Ugprade


https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/