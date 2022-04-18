Prerequistes:
- Login with IAM user
- Create Cloud9(=Cloud IDE) WorkStation, Expand EC2 Volume (10->200 GB), Restart EC2
- Activate python virtual environment, eksAdmin
- Run eks cluster

export WORKDIR='/home/ec2-user/environment'
cd $WORKDIR

#########################################################################################
# 1. (eksAdmin) Deploy airflow with gitops
#########################################################################################

cp config/airflow-staging.yml airflow-eks-config/releases/


#########################################################################################
# 2. (eksAdmin) git commit
#########################################################################################

cd airflow-eks-config
git add .
git commit -am "airflow ts7"
git push


#########################################################################################
# 3. (eksAdmin) sync manually
#########################################################################################

fluxctl sync --k8s-fwd-ns flux


#########################################################################################
# 4. (eksAdmin) logs
#########################################################################################

kubectl -n flux get po
NAME                              READY   STATUS    RESTARTS   AGE
flux-68694f44bb-kpcm5             1/1     Running   0          117m
flux-memcached-6dfbb4fccd-rzhgm   1/1     Running   0          9h
helm-operator-67b447574b-mbbq5    1/1     Running   0          9h

kubectl -n flux logs flux-68694f44bb-kpcm5 | grep airflow
ts=2022-04-09T18:41:13.860078539Z caller=loop.go:134 component=sync-loop event=refreshed url=ssh://git@github.com/jungfrau70/airflow-eks-config branch=master HEAD=b1196ea6e1a3896c226a5846b3168aa741470b77
ts=2022-04-09T18:41:14.647987271Z caller=sync.go:608 method=Sync cmd="kubectl apply -f -" took=361.958312ms err=null output="namespace/dev unchanged\nnamespace/production unchanged\nnamespace/staging unchanged\nhelmrelease.helm.fluxcd.io/airflow created"
ts=2022-04-09T18:41:14.648980858Z caller=daemon.go:701 component=daemon event="Sync: b1196ea, production:helmrelease/airflow" logupstream=false
ts=2022-04-09T18:41:19.366191575Z caller=loop.go:134 component=sync-loop event=refreshed url=ssh://git@github.com/jungfrau70/airflow-eks-config branch=master HEAD=b1196ea6e1a3896c226a5846b3168aa741470b77
ts=2022-04-09T18:43:58.625964253Z caller=loop.go:134 component=sync-loop event=refreshed url=ssh://git@github.com/jungfrau70/airflow-eks-config branch=master HEAD=b1196ea6e1a3896c226a5846b3168aa741470b77

kubectl -n flux logs helm-operator-67b447574b-mbbq5


#########################################################################################
# 5. (eksAdmin) Create Helm Chart in Github
#########################################################################################

git init
git remote add origin https://github.com/jungfrau70/helm-chart-airflow-eks.git
helm repo index --url https://jungfrau70.github.io/helm-chart-airflow-eks/ .
helm repo index --url https://github.com/jungfrau70/helm-chart-airflow-eks/ .
  
git add .
git commit -am "helm chart - airflow eks ::: v2"
git push