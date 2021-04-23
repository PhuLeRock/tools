### For part1-helm
# Install package
helm install part1-helm
# Check IP:80 for nginx to see if it's deployed
# You can delete package that are deployed by
helm delete <name-of-helm-deployment> 
# Packages will be deployed



### For part2-helm
# After deployed you can check nginx version by executing a sample pod nginx command
kubectl exec <pod-name> -- nginx -v
# use helm upgrade to set variable for our deployment

## UPGRADE
helm upgrade --set scale=9,tag="1.12" <name-of-helm-deployment> ./part2-helmValues
# Get name-of-helm-deployment with helm list
# Check pods number and their status it will generate 9 pod with nginx version 1.12 after
# the above command
kubectl exec <pod-name> -- nginx -v
# You will see nginx version 1.12 output

## ROLLBACK
helm list
## Check revision of helm deployment
## We now roll back to revision 1 which had 3 pods and nginx version 1.13 
# Note: current is revision 2 with 9 pods and nginx version 1.12
helm rollback <name-of-helm-deployment> 1
# Use kubectl to see if they are executing and terminating
kubectl exec <pod-name> -- nginx -v
# You will see nginx version 1.13 and 3 pods
# Normally you will have to use so many apply create update command by kubectl but for
# helm it's much more simpler





