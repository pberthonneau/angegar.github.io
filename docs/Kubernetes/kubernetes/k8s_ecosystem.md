<div style="float: right;width:100px">
<img src="https://render.bitstrips.com/v2/cpanel/fb695398-7ef1-4461-987b-73d3a97805fd-bc9fa5d8-e141-4ea4-879d-bc3d4b22abbc-v1.png?transparent=1&palette=1"/>
</div>

<div style="fload:left;width:300px">
<img src="https://www.underconsideration.com/brandnew/archives/dxc_technology_logo_new.png"/>
</div>



# Introduction to the Kubernetes ecosystem

> *Kubernetes is an open-source system for automating deployment, scaling, and management of containerized applications.*([kubernetes.io](https://kubernetes.io/))

In this document i will talk only about the tools which i played with.

## Architecture

### cluster


<div style='float:left;  max-width: 50%;height: auto' >
<img src="https://d33wubrfki0l68.cloudfront.net/99d9808dcbf2880a996ed50d308a186b5900cec9/40b94/docs/tutorials/kubernetes-basics/public/images/module_01_cluster.svg"/>

</div>
<div style='float:right; max-width: 50%;height: auto; padding-top:50px' >
A kubernetes cluster is composed of one or several master servers managing slave servers hosting applications.

</div>

<div class="spacer" style="clear: both;"></div>

### node
<div style='float:left; max-width: 50%;height: auto; padding-top:50px'>
A node is a virtual or physical server managed by kubernetes. Each node contains the services used to run pods :

- Docker host : Used to host the containers
- kubelet : Used to manage / orchestrate container deployment
- kube-proxy : Used to proxyfy the node connections


A node is composed of several pods which are logical set of kubernetes component. A pod can contains multiple containers working together to provide a service.
</div>

<div style='float:right; max-width: 50%;height: auto' >
<img src="https://www.nexworld.fr/wp-content/uploads/2017/07/kubernetes2.jpg"/>
</div>

<div class="spacer" style="clear: both;"></div>

## Why do we need kubernetes ?

- Enable portability accross infrastructure providers
- Orchestrate deployments to ensure a zero down time
- Rollback deployment if required
- Offer a common way to deploy application
- Offer redundancy for masters, nodes and pods
- Segregation per namespaces
- Mutualize physcial ressources

## Administrate a cluster

Kubernetes Operations ([Kops](https://github.com/kubernetes/kops)) is used to:

- Install kubernetes
- Update / Upgrade kubernetes
- Resize the cluster

## Deploy services

### kubectl
Kubernetes commandlet ([kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)) is used to :

- Deploy kubernetes manifests
- Update deployments / services
- Get kubernetes component status

### helm
[Helm](https://helm.sh/) is a kubernetes package manager used to :

- Deploy kubernetes packages
- Update kubernetes packages
- Remove kubernetes packages
- Rollback deployments


<div style="display: block; margin: auto; width:50%">
<img  src="https://render.bitstrips.com/v2/cpanel/d8e66e64-ec9c-495f-947e-9bfe52d2523f-bc9fa5d8-e141-4ea4-879d-bc3d4b22abbc-v1.png?transparent=1&palette=1"/>
</div>


## [Access the tutorial](README.md)