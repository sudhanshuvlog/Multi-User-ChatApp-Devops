[root@ip-172-31-43-77 /]# history
    1  cd /
    2  yum install docker -y
    3  docker run -p 8080:8080 -p 50000:50000 --name jenkins -dit --restart=on-failure -v jenkins_home:/var/jenkins_home jenkins/jenkins:lts-jdk21
    4  systemctl start docker
    5  docker run -p 8080:8080 -p 50000:50000 --name jenkins -dit --restart=on-failure -v jenkins_home:/var/jenkins_home jenkins/jenkins:lts-jdk21
    6  docker ps
    7  docker exec -it jenkins cat /var/jenkins_home/secrets/initialAdminPassword
    8  wget https://download.oracle.com/java/17/archive/jdk-17.0.10_linux-x64_bin.rpm
    9  yum install jdk-17.0.10_linux-x64_bin.rpm -y
   10  yum install git -y
   11  mkdir data
   12  curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
   13  sudo mv /tmp/eksctl /usr/local/bin
   14  eksctl version
   15  curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.19.6/2021-01-05/bin/linux/amd64/kubectl
   16  chmod +x ./kubectl
   17  sudo mv ./kubectl /usr/local/bin
   18  kubectl version --short --client
   19  aws configure
   20  eksctl create cluster --name EKSCHAT --region ap-south-1 --vpc-public-subnets=subnet-0e64ffc947ac8929c,subnet-04c1ed6ba9c55ffd7 --nodegroup-name default-ng --node-type t3.medium --nodes=2 --nodes-min=2 --nodes-max=2 --node-volume-size=20 --ssh-access --ssh-public-key DevOps --managed
   21  curl -sO http://15.207.72.26:8080/jnlpJars/agent.jar
   22  java -jar agent.jar -url http://15.207.72.26:8080/ -secret b3a43e3170ce4ca69e96a8ad2f6c0bad22306a449fd9143ea9a838a39a0025eb -name ec2 -webSocket -workDir "/data" &
   23  yum whatprovides mysql
   24  yum install mariadb105-3:10.5.29-1
   25  yum install mariadb105-3:10.5.29-1.amzn2023.0.1.x86_64 -y > /dev/null
   26  mysql -h database-1.cbaw4kes2epe.ap-south-1.rds.amazonaws.com
   27  mysql -h database-1.cbaw4kes2epe.ap-south-1.rds.amazonaws.com -u admin -p
   28  kubectl get pods --namespace dev 
   29  kubectl get svc  --namespace dev 
   30  kubectl get svc  --namespace prod 
   31  kubectl describe configmap --namespace prod
   32  kubectl edit configmap backend-config --namespace prod
   33  kubectl get svc multi-chat-backend-service -o jsonpath='{.status.loadBalancer.ingress[0].hostname}' --namespace prod
   34  kubectl edit configmap backend-config --namespace prod
   35  kubectl get pod --namespace prod
   36  kubectl delete pod multi-chat-frontend-dbb6dbd75-cmmg7  multi-chat-frontend-dbb6dbd75-cv2d4
   37  kubectl delete pod multi-chat-frontend-dbb6dbd75-cmmg7  multi-chat-frontend-dbb6dbd75-cv2d4 --namespace prod
   38  kubectl get pod --namespace prod
   39  docker exec -it multi-chat-frontend-dbb6dbd75-8rpmx bash
   40  docker exec -it multi-chat-frontend-dbb6dbd75-8rpmx -- bash
   41  docker exec -it multi-chat-frontend-dbb6dbd75-8rpmx -- bash --namespace prod
   42  docker exec -it multi-chat-frontend-dbb6dbd75-8rpmx -- bash --namespace prod
   43  kubectl get pod --namespace prod
   44  docker exec -it multi-chat-frontend-dbb6dbd75-8rpmx -- bash --namespace prod
   45  kubectl exec -it multi-chat-frontend-dbb6dbd75-8rpmx -- bash --namespace prod
   46  kubectl exec -it multi-chat-frontend-dbb6dbd75-8rpmx -- bash --namespace prod
   47  kubectl get pods -n prod
   48  kubectl exec -it multi-chat-frontend-dbb6dbd75-xcqf8 -- bash -n prod
   49  kubectl exec -it multi-chat-frontend-dbb6dbd75-xcqf8 -n prod
   50   
   51  kubectl get pods -n prod
   52  kubectl get pods -n prod
   53  kubectl get pods -n prod
   54  kubectl get svc -n prod
   55  kubectl get configmap -n prod
   56  kubectl describe configmap -n prod
   57  kubectl get pods -n prod
   58  kubectl edit deployment multi-chat-frontend -n prod
   59  ubectl config set-context --current --namespace=prod
   60  kubectl config set-context --current --namespace=prod
   61  kubectl get pods
   62  kubectl exec -it multi-chat-frontend-fdbc9fbc8-55sww -- bash
   63  kubectl exec -it multi-chat-frontend-fdbc9fbc8-55sww -- /bin/bash
   64  kubectl exec -it multi-chat-frontend-fdbc9fbc8-55sww -- /bin/bash
   65  kubectl log multi-chat-frontend-fdbc9fbc8-55sww 
   66  kubectl logs multi-chat-frontend-fdbc9fbc8-55sww 
   67  kubectl get svc -n prod
   68  kubectl get pods -n dev
   69  kubectl get svc -n dev
   70  kubectl get pods -n dev
   71  kubectl get pods -n dev
   72  kubectl get pods -n dev
   73  kubectl get pods -n dev
   74  kubectl get pods -n dev
   75  kubectl get pods -n dev
   76  kubectl get pods -n dev
   77  kubectl get pods -n dev
   78  kubectl get pods -n dev
   79  kubectl get pods -n prod
   80  kubectl get pods -n prod
   81  cd /
   82  kubectl get pods --namespace dev
   83  kubectl get svc --namespace dev
   84  kubectl get svc --namespace prod
   85  kubectl get pods --namespace dev
   86  kubectl get pods --namespace dev
   87  kubectl get pods --namespace dev
   88  kubectl get pods --namespace dev
   89  kubectl get pods --namespace dev
   90  kubectl describe pod multi-chat-backend-5c57f989bd-kdrg4 -n dev
   91  kubectl get pods --namespace dev
   92  kubectl get pods --namespace dev
   93  kubectl get pods --namespace dev
   94  kubectl get pods --namespace dev
   95  kubectl get pods --namespace dev
   96  kubectl get pods --namespace dev
   97  kubectl get pods --namespace dev
   98  kubectl get pods --namespace dev
   99  kubectl get pods --namespace dev
  100  kubectl get pods --namespace dev
  101  kubectl get pods --namespace dev
  102  kubectl get pods --namespace dev
  103  kubectl get pods --namespace prod
  104  cd /
  105  history