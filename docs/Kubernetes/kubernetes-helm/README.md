<style>
  .clean {
    clear: both;
  }
</style>

<!-- <style>

img[src*="#questions"]{
  display: block;
  margin-left: auto;
  margin-right: auto;
  margin-top: 50px;
  width: 30%;

  border-radius: 25% 10%;
  border: solid;
}

img[src*="#helm"]{
  width: 25%;
}

.left {
  float: left;
  border-right: solid thin;
  padding-top: 0.6em;
  padding-right: 0.6em;
  overflow-wrap: normal;
  width: 49%;
}

.right {
  float: right;
  overflow-wrap: normal;
  padding-top: 0.6em;
  padding-left: 0.6em;
  width: 49%;
}

#page-header{
  width: 100%;
  text-align:center;
  opacity: 0.5;

}

.header-logo-right{
  display: inline-block;
  float: right;
  width: 10%;
}

.header-logo-center{
  display: inline-block;
  width: 10%;
  margin:0 auto;
}

#logo{
  float: right;
  width: 15%;
}
.clean {
  clear: both;
}

</style> 

<div id="page-header">
<div class="header-logo-right">
<a href="https://helm.sh/" target='_blank'><img src="https://blog.wescale.fr/content/images/2018/05/Helm-Logo_Plan-de-travail-1.png"/></a>
</div>
</div>

<div class="clean"></div>
-->
# Kubernetes - manage applications with Helm

## What is Helm ?

> Helm is for Kubernetes what apt is for Linux.

This is a package manager which allows to easily manage applications deployment in a repeatable manner.

## Helm benefits

- Share deployment manifest
- Version deployment manifest
- Split configuration from the deployment code
- Repeatable / predictable deployment
- Compose Helm package named Chart to create an application deployment

## Syntax

![Placeholder](https://www.ibm.com/cloud/architecture/images/courses/helm-fundamentals/helm-1-small.jpg#helm){ align=left width=300px loading=lazy }

The Helm engine is based on go template, so that, the syntax is composed of Kubernetes yaml manifests and go templates in addition to some Helm functions.

<div class="clean"></div>

Managing multiple environments only with Kubernetes manifests implies to either:

- Create one manifest file per environment
- Introduce some placeholder and create scripts to replace it from configuration files

Helm uses the Go template engine to separate the deployment configuration from the deployment logic, thus it becomes easy to apply one configuration per environment.

=== "Without Helm"

      ```yaml
      apiVersion: v1
      kind: Service
      metadata:
        name: hello-kubernetes
      spec:
      type: ClusterIP
      ports:
      - port: 80
        targetPort: 8080
      selector:
        app: hello-kubernetes
        
      ---

      apiVersion: apps/v1
      kind: Deployment
      metadata:
      name: hello-kubernetes
      spec:
      replicas: 2
      selector:
        matchLabels:
        app: hello-kubernetes
      template:
        metadata:
        labels:
          app: hello-kubernetes
        spec:
        containers:
        - name: hello-kubernetes
          image: paulbouwer/hello-kubernetes:1.8
          ports:
          - containerPort: 8080
          env:
          - name: MESSAGE
            value: Hello World
      ```

=== "With Helm"

      ```yaml
      apiVersion: v1
      kind: Service
      metadata:
        name: {{ .Values.app }}
      spec:
      type: ClusterIP
      ports:
      - port: 80
        targetPort: {{ .Values.port }}
      selector:
        app: {{ .Values.app }}
        
      ---

      apiVersion: apps/v1
      kind: Deployment
      metadata:
      name: {{ .Values.app }}
      spec:
      replicas: "{{ .Values.replicas }}"
      selector:
        matchLabels:
        app: {{ .Values.app }}
      template:
        metadata:
        labels:
          app: {{ .Values.app }}
        spec:
        containers:
        - name: hello-kubernetes
          image: "{{ .Values.image }}:{{ .Values.tag }}"
          ports:
          - containerPort: {{ .Values.port }}
          env:
          - name: MESSAGE
            value: {{ .Values.message}}
      ```

=== "Helm configuration file"

      ```yaml
      app: hello-kubernetes
      port: 8080
      image: paulbouwer/hello-kubernetes
      tag: 1.8
      replicas: 2
      message: My message coming from the config file
      ```

## Helm versions

They are two production versions of Helm, the version 2 based on a client server architecture and the version 3 which replaces the server side with a Helm library.

!!! quote inline "Helm 2"

    Client :

    - Local chart development
    - Managing repositories
    - Managing releases
    - Interacting with the Tiller server :
      - Sending charts to be installed
      - Asking for information about releases
      - Requesting upgrading or uninstalling of existing releases

    Server :

    - Listening for incoming requests from the Helm client
    - Combining a chart and configuration to build a release
    - Installing charts and then tracking the subsequent release
    - Upgrading and uninstalling charts
  
!!! quote inline end "Helm 3"

    Client :

    - Local chart development
    - Managing repositories
    - Managing releases
    - Interfacing  with the Helm library :
      - Sending charts to be installed
      - Requesting upgrading or uninstalling of existing releases

    Helm library :

    - Combining a chat and configuration to build a release
    - Installing charts to Kubernetes and proving the subsequent release object
    - Upgrading and uninstalling charts by interacting with Kubernetes

<div class="clean"></div>

![](./img/questions.png#questions){width=200px}

## Hands-on

### Deploy from your own chart

In this use case we will create a simple hello world web site and deploy it with a Helm chart.

```shell
helm create website
```

#### Folder structure

- charts folder: Used to contain chart dependencies / subcharts
- template folder: Contains the template files which are the Kubernetes parametrized manifest
- values.yaml: Used to configure the chart
- Chart.yaml: Used to describe the chart

> **Read the [official documentation](https://helm.sh/docs/chart_template_guide/getting_started/)**
**Templates folder**

Helm creates a package structure allowing us to deploy an application. We can see a *serviceaccount.yaml* file used to grant your application with permissions on the Kubernetes stack, the *ingress.yaml* and *service.yaml* files are used to access the application from outside the stack. Finally the *deployment.yaml* is used to deploy the application.

By default Helm creates a **deployment** object which is convenient for most of the use cases, however if you want to use a Kubernetes **statefulset** you will have to create the associated manifest file into the **templates** folder.

#### Configure the deployment

All the **deployment** parameters are gathered into the *values.yaml* file, by default Helm configures a Nginx stack deployment. We will change the configuration to deploy the httpd container. The **deployment** customization are in the *values-apache.yaml* file.

The default configuration exposes the port 80, to use another port you have to edit the deployment.yml file (copy the file to the Helm chart folder).

#### Install / upgrade

The command below performs an upgrade or update depending of if the application was already deployed or not.

```shell
helm upgrade --create-namespace --install --namespace helm-demo -f website/values.yaml -f website/values-apache.yaml website ./website
```

!!! note
  The values contained in the website/values.yaml are overwritten by the ones on the website/values-apache.yaml

*We can customize the message in using a lifecycle hook in the deployment object.*

```yaml
    lifecycle:
        postStart:
            exec:
              command: ["/bin/sh", "-c", "echo Hello world $(hostname -f) > /usr/local/apache2/htdocs/index.html"]
```

#### Delete the release

The command below is used to delete a Helm release

```shell
helm uninstall website -n helm-demo
helm list --all -n helm-demo
```

!!! info
    We can uninstall a release in keeping the history with the **--keep-history** options. It allows to be able to rollback to a previous version, even if this version as uninstalled.

### Deploy from an existing Chart

Helm uses multiple way to configure the chart to be deployed, you can use multiple values file in addition to command line interface (cli) parameters.

#### Install

```shell
kubectl create namespace helm-demo2
helm repo add bitnami https://charts.bitnami.com/bitnami
helm install --namespace helm-demo2 website2 -f values-bitnami.yaml --set cloneHtdocsFromGit.repository="https://lgil3:$GITHUB_PAT@github.dxc.com/Platform-DXC/devcloud-docs.git" bitnami/apache --version 7.3.16
```

The above command will read the configuration from the values.yaml file and overwrite the parameter cloneHtdocsFromGit.repository with the cli value. This precedence mechanism is useful to pass secrets to the chart from the execution context.

#### Verify

Verify pods are up and ready

```shell
kubectl get pods -n helm-demo2
```

List the installed Helm releases

```shell
helm list -n helm-demo2
```

#### Navigate

Open the [http://localhost](http://localhost) url to read the devcloud web site.

> ***Learnings***
>
> - Helm can deploy packages from Helm repositories.
> - A Helm chart can be configured from a configuration file or from the CLI
> - There is a configuration order of precedence between Helm configuration files and CLI

#### Upgrade

```shell
helm upgrade --create-namespace --namespace helm-demo2 -f values-bitnami.yaml --set cloneHtdocsFromGit.repository="https://lgil3:$GITHUB_PAT@github.dxc.com/Platform-DXC/devcloud-docs.git" website2 bitnami/apache --version 7.3.17
```

#### List history version

```shell
helm history website2 -n helm-demo2
```

#### Rollback

```shell
helm rollback -n helm-demo2 website2 1
```

![](./img/questions.png#questions){width=200px}

## Advanced usage

### Helm chart rendering

```shell
helm template -f ./website/values.yaml -f ./website/values-apache.yaml ./website
```

### Inject files in template

- Create a configuration file

```shell
echo '#Configuration file' > config
echo 'image: {{ .Values.image.repository }}' >> config
echo 'tag: {{ .Values.image.tag }}' >> config
```

- Create a configmap file

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  creationTimestamp: 2016-02-18T18:52:05Z
  name: config
data:
  config: |-
    {{ .Files.Get "config" | indent 4 }}
  
```

- Render the chart

```shell
helm template -f values.yaml -f values-apache.yaml ./
```

### Templating

- Replace the content of the configmap with

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: config
data:
  config: |-
    {{ .Files.Get "config" | indent 4 }}
  config2: |-
    {{ tpl (.Files.Get "config") . | indent 4 }}
```

### Loop

- Replace the content of the configmap with

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: config
data:
  config: |-
    {{ .Files.Get "config" | indent 4 }}
  config2: |-
    {{ tpl (.Files.Get "config") . | indent 4 }}
  {{- $files := .Files }}
  {{- range tuple "values.yaml" "values-apache.yaml"}}
  {{ . }}: |-
    {{ $files.Get . | indent 4 }}
  {{- end }}
```

### Flow Control

- Replace the content of the configmap with

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: config
data:
{{ if and $.Values.replicaCount (gt $.Values.replicaCount 1.0) }}
  config: |-
  {{ .Files.Get "config" | indent 4 }}
{{ else }}
  config2: |-
    {{ tpl (.Files.Get "config") . | indent 4 }}
  {{- $files := .Files }}
  {{- range tuple "values.yaml" "values-apache.yaml"}}
  {{ . }}: |-
    {{ $files.Get . | indent 4 }}
  {{- end }}
{{end}}
```

!!! info "tips and tricks"
    Here is the link to the Helm web site [tips and tricks](https://helm.sh/docs/howto/charts_tips_and_tricks/){target=blank}.