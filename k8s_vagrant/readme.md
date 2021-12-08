# **Kubernetes**

## Install Vagrant

```
choco install vagrant
```
## Install Vagrant-hostmanager plugin

```
vagrant plugin install vagrant-hostmanager

```

## Start kubernate cluster

```
vagrant up

```

# **Helm**

## Installing and Testing Helm and Tiller

Let's get logged into the Kube Master:

```
vagrant ssh k8s-master

```
Once we answer yes at the authenticity warning prompt, and we're in. The Lay of the Land

Let's see what we're dealing with, as far as Kubernetes goes:

```
kubectl get nodes

```

That will show that we have three nodes running, and one of them is a master.
Install Helm and Tiller in the Existing Cluster

## Download the helm binary release:

```
curl https://storage.googleapis.com/kubernetes-helm/helm-v2.12.3-linux-amd64.tar.gz > ./helm.tar.gz

```

If we run a quick ls, we'll see that new helm.tar.gz sitting in our directory. Extract the archive:

```
tar -xvf ./helm.tar.gz

```

Now we can navigate to the linux-amd64 directory:

```
cd linux-amd64

```

If we run another ls, we'll see two executable files, helm and tiller. Let's move them to the /usr/local/bin directory:

```
sudo mv ./helm /usr/local/bin

sudo mv ./tiller /usr/local/bin

```

To ensure that the helm command is available, let's get back into our home directory and run the helm version command:

```
cd ~

helm version

```

We get a version, meaning Helm is good to go, but we get an error that Helm couldn't find Tiller. So we can install it with this:

```
helm init

```

Run the version command again to ensure that Tiller is available:

```
helm version

```

Now we can see that there's a Tiller server.

## Create service account:

```
kubectl create serviceaccount --namespace kube-system tiller

```

Now we'll create a Tiller cluster rule:

```
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller

```

Let's patch the Tiller deployment:

```
kubectl patch deploy --namespace kube-system tiller-deploy -p'{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'

```

## installing the wordpress example chart :

```
cd /vagrant/deploy_services_with_helm && helm install ./wordpress

```

Verify That the Container is Running

Once the release has completed and we see the release output, let's locate the cluster IP for the service that has been created. We're going to need that to confirm that the wordpress pod has been deployed correctly:


> 1) Get the WordPress URL:

```
  export NODE_PORT=$(kubectl get --namespace default -o jsonpath="{.spec.ports[0].nodePort}" services pioneering-prawn-wordpress)
  
  export NODE_IP=$(kubectl get nodes --namespace default -o jsonpath="{.items[0].status.addresses[0].address}")
  
  echo "WordPress URL: http://$NODE_IP:$NODE_PORT/"
  
  echo "WordPress Admin URL: http://$NODE_IP:$NODE_PORT/admin"

```

> 2) Login with the following credentials to see your blog

```
  echo Username: user
  
  echo Password: $(kubectl get secret --namespace default pioneering-prawn-wordpress -o jsonpath="{.data.wordpress-password}" | base64 --decode)

```

## Finishing Up

Our Helm release was just a test, so we need to clean it up so that developers can get in here to work on a something fresh. We do that by getting the release name from Helm, and then deleting that release:

```
helm ls --short`

helm delete <RELEASE NAME>

```

To confirm that the release has been removed, we can run these commands, which should return nothing:

```
helm ls

kubectl get pods

```

## Conclusion

Well, we've installed Helm from our binary, corrected an issue with the service account, and now we can actually deploy Helm releases. We're good to go. Congratulations!