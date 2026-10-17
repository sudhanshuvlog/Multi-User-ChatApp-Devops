[root@ip-172-31-7-13 /]# history
    1  cd /
    2  yum install docker -y
    3  systemclt start docker
    4  systemctl start docker
    5  docker run -p 8080:8080 -p 50000:50000 --name jenkins -dit --restart=on-failure -v jenkins_home:/var/jenkins_home jenkins/jenkins:lts-jdk21
    6  docker p
    7  docker ps
    8  docker exec -it jenkins cat /var/jenkins_home/secrets/initialAdminPassword
    9  sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
   10  chmod +x /usr/local/bin/docker-compose
   11  docker-compose --version
   12  vi docker-compose.yaml
   13  docker-compose up -d
   14  docker ps
   15  curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
   16  sudo mv /tmp/eksctl /usr/local/bin
   17  eksctl version
   18  curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.36.2/2026-07-05/bin/linux/amd64/kubectl
   19  chmod +x ./kubectl
   20  cp ./kubectl /usr/local/bin/
   21  aws configure
   22  clear
   23  aws s3 ls
   24  eksctl create cluster --name EKSCHAT --region ap-south-1 --vpc-public-subnets=subnet-0e64ffc947ac8929c,subnet-04c1ed6ba9c55ffd7 --nodegroup-name default-ng --node-type t3.medium --nodes=2 --nodes-min=2 --nodes-max=2 --node-volume-size=20 --ssh-access --ssh-public-key DevOps --managed
   25  vi docker-compose.yaml 
   26  wget https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.rpm
   27  yum install jdk-21_linux-x64_bin.rpm -y
   28  mkdir data
   29  curl -sO http://15.206.210.155:8080/jnlpJars/agent.jar
   30  java -jar agent.jar -url http://15.206.210.155:8080/ -secret 0853b24614e084d9b0cf115b7ce58f982f79e9aa10502ee46c795fdeea949dba -name ec2 -webSocket -workDir "/data" &
   31  yum install git -y
   32  kubectl get pods
   33  kubectl get pods --namespace kube-system
   34  sudo yum install -y https://dev.mysql.com/get/mysql84-community-release-el9-1.noarch.rpm
   35  dnf install -y mysql-community-client
   36  mysql -h database-1.cbaw4kes2epe.ap-south-1.rds.amazonaws.com -u admin -p
   37  kubectl get namespaces
   38  kubectl get namespaces
   39  kubectl get pods
   40  kubectl get pods -n dev
   41  kubectl get secret -n dev
   42  kubectl get svc -n dev
   43  kubectl get ns
   44  kubectl get pods -n prod
   45  kubectl get pods -n svc
   46  kubectl get svc -n prod
   47  mysql -h database-1.cbaw4kes2epe.ap-south-1.rds.amazonaws.com -u admin -p
   48  kubectl get svc -n prod
   49  kubectl get pods -n dev
   50  kubectl get pods -n dev
   51  kubectl get pods -n dev
   52  kubectl get pods -n dev
   53  kubectl get pods -n dev
   54  kubectl get pods -n dev
   55  kubectl get svc -n dev
   56  kubectl get svc -n prod
   57  kubectl get pods -n prod
   58  kubectl get pods -n prod
   59  kubectl get pods -n prod
   60  history
