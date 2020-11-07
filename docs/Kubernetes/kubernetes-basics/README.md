# Kubernetes basic - The hard way

This training is intended to help developers to understand Kubernetes fundamentals. We will not use advanced tools such as Helm but instead we will do every step manually with kubectl and yaml manifests.

As a use case we will work on the deployment of the Atlassian Confluence application.

You will find all the Kubernetes manifest use in this course into the manifests folder.

## Create a namespace

*In Kubernetes a namespace is used to isolate resources, in a multi-tenant environment it is wise to create one namespace per tenant.*

Let's create a namespace for our application.

`kubectl apply -f manifests/namespace.yaml`

## Create a pod

*A pod is composed of one or multiple containers acting together to provide a service. Each container inside a pod share the same node, the same IP and the same volumes.*

Deploy our application pod in the demo namespace

`kubectl apply -f manifests/pod.yaml --namespace demo`

Verify the pods was correctly created 

`kubectl get pods --namespace demo`

Open a tunnel to your pod

 `kubectl port-forward -n demo pod/confluence 8080:8090`

Open your navigator and go to http://localhost:8080

After this first step you have a single pod hosting your application which is not accessible from internet. As the pod has an IP adresse your can access it from the cluster only (internally accessible).

## Create a service

*A service is a way to abstract the underlayer pods. There are several kind of services, ClusterIP(the default one), LoadBalancer, NodePort and ExternalName. A service act as a load balancer between pods of the same nature.*

Deploy our service in the demo namespace

`kubectl apply -f manifests/service.yaml --namespace demo`

Verify that your service route the trafic to your pod 

`kubectl port-forward -n demo svc/confluence-svc 8080:8090`

Go to http://localhost:8080

Describe your service and verify the target endpoint

`kubectl describe svc confluence-svc -n demo`

Deploy another confluence pods

`kubectl apply -f manifests/pod-1.yaml --namespace demo`

Describe your service and verify the target endpoints

 `kubectl describe svc confluence-svc -n demo`

**Note: You will see 2 IPs adresses matching the 2 pods created**

Is your service publicly accessible :

`kubectl get svc confluence-svc -n demo`

**Note: the external IP is empty, this is because a sevice of type ClusterIP is not internet facing.**

## Make your service publicly accessible

List aws loadbalancers

`aws elbv2 describe-load-balancers`

Change the service type to LoadBalancer and apply your changes

`kubectl apply -f manifests/service.yaml --namespace demo`

Get the service external IP

`kubectl get svc confluence-svc -n demo`

Your service is now associated with and external ip (fqdn) matching an AWS classic load balancer created by kubernetes. 

Get your public url and navigate to the url

`echo "http://$(kubectl get svc confluence-svc -n demo -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'):8090"`

Your application is now accessible from internet through an AWS Classic Load Balancer.

## Create a replicaset

*A replicaset is used to manage the number of pods. If you want to scale you modify the replicaset configuration to increase the number of replica, then you will new pods spun-up.

`kubectl apply -f manifests/replicaset.yaml -n demo`

A replicaset acquires all the pods with specific labels, even if it did not create those pods.

Try the command below and observe the pods in the demo namespace

`kubectl apply -f manifests/pod.yaml --namespace demo`

The pod is automatically shutdowned by the replicaset as we specified only 1 replica.

**Note: Replicaset is a good way to create a canary deployment**

## Create a deployment

*A deployment is a Kubernetes object used to manage pods. It creates and manages a replicaset which is used to configure the number of replica and all the deployment aspects of a pod. This is the default way to deploy stateless applications.*

`kubectl apply -f manifests/deployment.yaml --namespace demo`

Verify if it was created

`kubectl get deployment --namespace demo`

List the replicaset inside the namespace

`kubectl get replicaset -n demo`

The deployment created a replicaset. Now, there are 2 replicasets managing the same pods, thus we may see inconsistencies.

Delete the first replicaset created

`kubectl delete replicaset confluence-replicaset -n demo`

## Create a statefulset

*A statefulset is a Kubernetes object used to manage pods. It has its own control plain to manage the number of replica. It is mainly used to manage stateful applications.*

Deploy your application with a statefulset

`kubectl apply -f manifests/statefulset.yaml --namespace demo`

Check the status

`kubectl describe statefulset confluence --namespace demo`

Check the pods

`kubectl get pods --namespace demo`

**Note: It is interesting to see that the statefulset counts only the pods it creates. This is because it has its own control plain.**

During the deployment we requested for persistent storage.

List the persistent volume claim

`kubectl get persistentvolumeclaim --namespace demo`

Look for the storage in AWS

`aws ec2 describe-volumes --filter Name=tag:kubernetes.io/created-for/pvc/namespace,Values=demo --query "Volumes[*].{ID:VolumeId}`

Delete the statefulset

`kubectl delete statefulset confluence --namespace demo`

`aws ec2 describe-volumes --filter Name=tag:kubernetes.io/created-for/pvc/namespace,Values=demo --query "Volumes[*].{ID:VolumeId}"`

The disk are still there.

**Note: PersistentVolume Claims are not deleted when the Pods, or StatefulSet are deleted. This must be done manually.**

Deploy again the statefulset

`kubectl apply -f manifests/statefulset.yaml --namespace demo`

The new pods should be attached to the previously created volumes

## Ingress

Create the ingress

`kubectl apply -f manifests/ingress.yaml`

Try to access http://confluence-demo.platformdxc-mg-d0.com

## Persistent volume claim

As the default pod storage type (emptyDir) is epheral we may need to create permanent disk with the persistent volume claim;

# References

https://kubernetes.io/fr/docs/reference/kubectl/

https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.15

https://confluence.atlassian.com/confkb/how-to-generate-a-new-confluence-cfg-xml-425461512.html?_ga=2.16139198.924632318.1562615698-1640495167.1558622810

https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/