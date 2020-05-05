To change the behavior edit the hello-world-app.yaml (e.g. to specify the correct ingress.host value for your environment)

Currently uses this project:
https://hub.docker.com/r/eltondesouza/go-hello-world
which uses a multi-arch image that will run on x86 and z to demonstrate MCM capabilities
Image at docker.io/eltondesouza/go-hello-world:latest

### Clusters with tag on environment=Demo will get the app deployed. Look at Route in hello-world NS for url.

## Installation as native MCM app

To install hello-world as MCM native app you need a cluster with IBM CloudPak for Multicluster Management 1.3

1. Create namespaces **hello-world-source** and **hello-world-project**. For Openshift run:

   ```bash
   oc new-project hello-world-source
   oc new-project hello-world-project
   ```

2. Create a hello-world channel:

   ```bash
   kubectl apply -f hello-world-ns-channel.yaml
   ```

3. Create a hello-world placementrules

   ```bash
   kubectl apply -f hello-world-placementrules.yaml
   ```

4. Create a hello-world application deployables:

   ```bash
   kubectl apply -f hello-world-deployable.yaml
   ```

5. Create a hello-world application and subscription CRDs:

   ```bash
   kubectl apply -f hello-world-prereq.yaml
   kubectl apply -f hello-world-flat-app.yaml
