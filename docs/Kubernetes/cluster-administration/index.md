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

## Deployment

## Network

## Ugprade