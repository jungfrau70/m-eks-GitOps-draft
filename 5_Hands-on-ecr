
export WORKDIR='/home/ec2-user/environment/eks/04_registry-ecr'
cd $WORKDIR

cat >Dockerfile<<EOF
FROM alpine
CMD ["echo", "Hello StackOverflow!"]
EOF

cat Dockerfile

docker build -t hello-world .

docker images --filter reference=hello-world

docker run -t -i -p 80:80 hello-world

docker images --filter reference=jupyterlab

curl localhost -v

docker tag hello-world:latest ${ACCOUNT_ID}.dkr.ecr.ap-northeast-2.amazonaws.com/hello-world:latest

#cat ~/.aws/credentials

cat ~/.aws/config

aws ecr get-login-password --region ap-northeast-2 | docker login --username AWS --password-stdin ${ACCOUNT_ID}.dkr.ecr.ap-northeast-2.amazonaws.com

aws ecr create-repository  --repository-name hello-world  --image-scanning-configuration scanOnPush=true  --region ap-northeast-2

docker push ${ACCOUNT_ID}.dkr.ecr.ap-northeast-2.amazonaws.com/hello-world:latest

cat ~/.docker/config.json

aws ecr delete-repository  --repository-name hello-world  --force
