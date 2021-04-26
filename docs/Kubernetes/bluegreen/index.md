# Blue green with Kubernetes

Blue-Green is a well known deployment pattern which I will not cover here. The purpose of this course it to deploy your first blue green application.

## Kubernetes implementation

In Kubernetes, such as in other platforms,  we are doing blue green deployment in switching the route from an old stable resource to a new one. Let's draw it.

### Service level

![](./bluegreen2.drawio.png)

A blue green implementation at the Kubernetes service level will work, indeed a service has selectors used to identify the to route the traffic to. Although this solution is simple to implement, there are some drawbacks. Both pods versions must be deployed inside the same namespace which increase the risk of downtime in case of deployment troubles. In addition the newly created pods will not be exposed through a service as the only service is targeting the old version, thus it will be difficult to test the new version.

!!! warning
        Although this solution may work, it is not recommended to use it for production workload.

### Ingress level

![](./bluegreen.drawio.png)

In this schema, we see the current stable application inside the blue circle, those pods are exposed through a Kubernetes service with the label selector V1. The green pods are the new ones exposed with label selector V2, to perform a blue green deployment the ingress controller will be updated to direct the traffic to the V2 service.

## Basic example based on nginx ingress

Nginx reverse proxy, it a well known reverse proxy server created several years ago. There were a portage in Kubernetes to use it as Kubernetes Ingress Controller. Of course all the Nginx feature are available in its ingress version. In this hands-on, you will go over a simple code used to demonstrate how it can be used to perform a blue green deployment.

## Advanced with Istio

TBD