Prerequistes:
- Login with IAM user
- Create Cloud9(=Cloud IDE) WorkStation, Expand EC2 Volume (10->200 GB), Restart EC2
- Activate python virtual environment, eksAdmin
- Run eks cluster

export WORKDIR='/home/ec2-user/environment'
cd $WORKDIR


#########################################################################################
# 1. (eksAdmin) Deploy ALB controller
#########################################################################################

cd eks/04_alb-controller/

bash 1_deploy.sh 

#########################################################################################
# 2. (eksAdmin) Check if alb pods run
#########################################################################################

kubectl get po -A

NAMESPACE     NAME                                            READY   STATUS    RESTARTS   AGE
kube-system   aws-load-balancer-controller-85cfbbd877-2cmvq   1/1     Running   0          6m49s
kube-system   aws-load-balancer-controller-85cfbbd877-6gzrg   1/1     Running   0          6m49s
kube-system   aws-node-hkmll                                  1/1     Running   0          9m46s
kube-system   aws-node-p7899                                  1/1     Running   0          9m44s
kube-system   aws-node-q8bwc                                  1/1     Running   0          9m45s
kube-system   coredns-6dbb778559-lbrsc                        1/1     Running   0          23m
kube-system   coredns-6dbb778559-xhxbm                        1/1     Running   0          23m
kube-system   kube-proxy-7v4dc                                1/1     Running   0          9m45s
kube-system   kube-proxy-fxqvd                                1/1     Running   0          9m44s
kube-system   kube-proxy-xmpdh                                1/1     Running   0          9m46s


#########################################################################################
# 2. (eksAdmin) (If required) Trouble shooting
#########################################################################################

cd aws-load-balancer-controller/
eksctl get cluster production
helm install aws-load-balancer-controller .             --set clusterName=$CLUSTER             --set serviceAccount.create=false             --set serviceAccount.name=aws-load-balancer-controller \
kubectl -n production describe po airflow-production-create-user-5fr42 
kubectl get deploy -n production
kubectl -n production describe deploy aws-load-balancer-controller
helm delete aws-load-balancer-controller -n production
helm ls -A
