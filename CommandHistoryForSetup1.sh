[root@ip-172-31-12-10 /]# docker ps
CONTAINER ID   IMAGE                       COMMAND                  CREATED         STATUS         PORTS                                                                                      NAMES
aa81f769542c   sonarqube                   "/opt/sonarqube/dock…"   2 minutes ago   Up 2 minutes   0.0.0.0:9000->9000/tcp, :::9000->9000/tcp                                                  sonarqube
cf16d65e4a96   postgres:12                 "docker-entrypoint.s…"   2 minutes ago   Up 2 minutes   0.0.0.0:5432->5432/tcp, :::5432->5432/tcp                                                  sonarqube-database
3a6f041d5f71   jenkins/jenkins:lts-jdk21   "/usr/bin/tini -- /u…"   8 minutes ago   Up 8 minutes   0.0.0.0:8080->8080/tcp, :::8080->8080/tcp, 0.0.0.0:50000->50000/tcp, :::50000->50000/tcp   jenkins
[root@ip-172-31-12-10 /]# curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
eksctl version
0.226.0
[root@ip-172-31-12-10 /]# curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.19.6/2021-01-05/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin
kubectl version --short --client
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 58875k 100 58875k   0     0  5814k     0   0:00:10  0:00:10 --:--:--  6911k
Client Version: v1.19.6-eks-49a6c0
[root@ip-172-31-12-10 /]# eksctl create cluster --name EKSCHAT --region ap-south-1 --vpc-public-subnets=subnet-0e64ffc947ac8929c,subnet-04c1ed6ba9c55ffd7 --nodegroup-name default-ng --node-type t3.medium --nodes=2 --nodes-min=2 --nodes-max=2 --node-volume-size=20 --ssh-access --ssh-public-key DevOps --managed
2026-05-24 05:55:03 [ℹ]  eksctl version 0.226.0
2026-05-24 05:55:03 [ℹ]  using region ap-south-1
2026-05-24 05:55:04 [✔]  using existing VPC (vpc-098858f3f7c9641b7) and subnets (private:map[] public:map[ap-south-1a:{subnet-0e64ffc947ac8929c ap-south-1a 172.31.32.0/20 0 } ap-south-1b:{subnet-04c1ed6ba9c55ffd7 ap-south-1b 172.31.0.0/20 0 }])
2026-05-24 05:55:04 [!]  custom VPC/subnets will be used; if resulting cluster doesn't function as expected, make sure to review the configuration of VPC/subnets
2026-05-24 05:55:04 [ℹ]  nodegroup "default-ng" will use "" [AmazonLinux2023/1.34]
2026-05-24 05:55:04 [ℹ]  using EC2 key pair "DevOps"
2026-05-24 05:55:04 [!]  Auto Mode will be enabled by default in an upcoming release of eksctl. This means managed node groups and managed networking add-ons will no longer be created by default. To maintain current behavior, explicitly set 'autoModeConfig.enabled: false' in your cluster configuration. Learn more: https://eksctl.io/usage/auto-mode/
2026-05-24 05:55:04 [ℹ]  using Kubernetes version 1.34
2026-05-24 05:55:04 [ℹ]  creating EKS cluster "EKSCHAT" in "ap-south-1" region with managed nodes
2026-05-24 05:55:04 [ℹ]  will create 2 separate CloudFormation stacks for cluster itself and the initial managed nodegroup
2026-05-24 05:55:04 [ℹ]  if you encounter any issues, check CloudFormation console or try 'eksctl utils describe-stacks --region=ap-south-1 --cluster=EKSCHAT'
2026-05-24 05:55:04 [ℹ]  Kubernetes API endpoint access will use default of {publicAccess=true, privateAccess=false} for cluster "EKSCHAT" in "ap-south-1"
2026-05-24 05:55:04 [ℹ]  CloudWatch logging will not be enabled for cluster "EKSCHAT" in "ap-south-1"
2026-05-24 05:55:04 [ℹ]  you can enable it with 'eksctl utils update-cluster-logging --enable-types={SPECIFY-YOUR-LOG-TYPES-HERE (e.g. all)} --region=ap-south-1 --cluster=EKSCHAT'
2026-05-24 05:55:04 [ℹ]  default addons vpc-cni, kube-proxy, coredns, metrics-server were not specified, will install them as EKS addons
2026-05-24 05:55:04 [ℹ]  
2 sequential tasks: { create cluster control plane "EKSCHAT", 
    2 sequential sub-tasks: { 
        2 sequential sub-tasks: { 
            1 task: { create addons },
            wait for control plane to become ready,
        },
        create managed nodegroup "default-ng",
    } 
}
2026-05-24 05:55:04 [ℹ]  building cluster stack "eksctl-EKSCHAT-cluster"
2026-05-24 05:55:04 [ℹ]  deploying stack "eksctl-EKSCHAT-cluster"
2026-05-24 05:55:34 [ℹ]  waiting for CloudFormation stack "eksctl-EKSCHAT-cluster"
2026-05-24 05:56:04 [ℹ]  waiting for CloudFormation stack "eksctl-EKSCHAT-cluster"
2026-05-24 05:57:04 [ℹ]  waiting for CloudFormation stack "eksctl-EKSCHAT-cluster"
2026-05-24 05:58:04 [ℹ]  waiting for CloudFormation stack "eksctl-EKSCHAT-cluster"
2026-05-24 05:59:04 [ℹ]  waiting for CloudFormation stack "eksctl-EKSCHAT-cluster"
2026-05-24 06:00:04 [ℹ]  waiting for CloudFormation stack "eksctl-EKSCHAT-cluster"
2026-05-24 06:01:04 [ℹ]  waiting for CloudFormation stack "eksctl-EKSCHAT-cluster"
2026-05-24 06:02:04 [ℹ]  waiting for CloudFormation stack "eksctl-EKSCHAT-cluster"
2026-05-24 06:03:04 [ℹ]  waiting for CloudFormation stack "eksctl-EKSCHAT-cluster"
2026-05-24 06:03:05 [!]  recommended policies were found for "vpc-cni" addon, but since OIDC is disabled on the cluster, eksctl cannot configure the requested permissions; the recommended way to provide IAM permissions for "vpc-cni" addon is via pod identity associations; after addon creation is completed, add all recommended policies to the config file, under `addon.PodIdentityAssociations`, and run `eksctl update addon`
2026-05-24 06:03:05 [ℹ]  creating addon: vpc-cni
2026-05-24 06:03:06 [ℹ]  successfully created addon: vpc-cni
2026-05-24 06:03:06 [ℹ]  creating addon: kube-proxy
2026-05-24 06:03:06 [ℹ]  successfully created addon: kube-proxy
2026-05-24 06:03:06 [ℹ]  creating addon: coredns
2026-05-24 06:03:07 [ℹ]  successfully created addon: coredns
2026-05-24 06:05:07 [ℹ]  building managed nodegroup stack "eksctl-EKSCHAT-nodegroup-default-ng"
2026-05-24 06:05:07 [ℹ]  deploying stack "eksctl-EKSCHAT-nodegroup-default-ng"
2026-05-24 06:05:07 [ℹ]  waiting for CloudFormation stack "eksctl-EKSCHAT-nodegroup-default-ng"
2026-05-24 06:05:37 [ℹ]  waiting for CloudFormation stack "eksctl-EKSCHAT-nodegroup-default-ng"
2026-05-24 06:06:25 [ℹ]  waiting for CloudFormation stack "eksctl-EKSCHAT-nodegroup-default-ng"
2026-05-24 06:08:03 [ℹ]  waiting for CloudFormation stack "eksctl-EKSCHAT-nodegroup-default-ng"
2026-05-24 06:08:03 [ℹ]  waiting for the control plane to become ready
2026-05-24 06:08:04 [✔]  saved kubeconfig as "/root/.kube/config"
2026-05-24 06:08:04 [ℹ]  no tasks
2026-05-24 06:08:04 [✔]  all EKS cluster resources for "EKSCHAT" have been created
2026-05-24 06:08:04 [ℹ]  nodegroup "default-ng" has 2 node(s)
2026-05-24 06:08:04 [ℹ]  node "ip-172-31-11-78.ap-south-1.compute.internal" is ready
2026-05-24 06:08:04 [ℹ]  node "ip-172-31-38-40.ap-south-1.compute.internal" is ready
2026-05-24 06:08:04 [ℹ]  waiting for at least 2 node(s) to become ready in "default-ng"
2026-05-24 06:08:04 [ℹ]  nodegroup "default-ng" has 2 node(s)
2026-05-24 06:08:04 [ℹ]  node "ip-172-31-11-78.ap-south-1.compute.internal" is ready
2026-05-24 06:08:04 [ℹ]  node "ip-172-31-38-40.ap-south-1.compute.internal" is ready
2026-05-24 06:08:04 [✔]  created 1 managed nodegroup(s) in cluster "EKSCHAT"
2026-05-24 06:08:04 [ℹ]  creating addon: metrics-server
2026-05-24 06:08:04 [ℹ]  successfully created addon: metrics-server
2026-05-24 06:08:05 [ℹ]  kubectl command should work with "/root/.kube/config", try 'kubectl get nodes'
2026-05-24 06:08:05 [✔]  EKS cluster "EKSCHAT" in "ap-south-1" region is ready
[root@ip-172-31-12-10 /]# 
[root@ip-172-31-12-10 /]# 
[root@ip-172-31-12-10 /]# 
[root@ip-172-31-12-10 /]# kubectl get pods
No resources found in default namespace.
[root@ip-172-31-12-10 /]# kubectl get pods -n kube-system
NAME                              READY   STATUS    RESTARTS   AGE
aws-node-5nlg6                    2/2     Running   0          49m
aws-node-z9m9b                    2/2     Running   0          49m
coredns-66cff8d9f9-2szl7          1/1     Running   0          53m
coredns-66cff8d9f9-w8sqr          1/1     Running   0          53m
kube-proxy-26fwf                  1/1     Running   0          49m
kube-proxy-p9djr                  1/1     Running   0          49m
metrics-server-85769fc6bd-nndrq   1/1     Running   0          48m
metrics-server-85769fc6bd-ptrfp   1/1     Running   0          48m
[root@ip-172-31-12-10 /]# mysql -h database-1.cbaw4kes2epe.ap-south-1.rds.amazonaws.com -P 3306 -u admin -p
bash: mysql: command not found
[root@ip-172-31-12-10 /]# yum whatrpovides mysql
No such command: whatrpovides. Please use /usr/bin/yum --help
It could be a YUM plugin command, try: "yum install 'dnf-command(whatrpovides)'"
[root@ip-172-31-12-10 /]# yum whatprovides mysql
Last metadata expiration check: 1:20:44 ago on Sun May 24 05:43:17 2026.
mariadb1011-3:10.11.11-1.amzn2023.0.1.x86_64 : A very fast and robust SQL database server
Repo        : amazonlinux
Matched from:
Filename    : /usr/bin/mysql

mariadb1011-3:10.11.11-1.amzn2023.0.2.x86_64 : A very fast and robust SQL database server
Repo        : amazonlinux
Matched from:
Filename    : /usr/bin/mysql

mariadb1011-3:10.11.13-1.amzn2023.0.1.x86_64 : A very fast and robust SQL database server
Repo        : amazonlinux
Matched from:
Filename    : /usr/bin/mysql

mariadb1011-3:10.11.15-1.amzn2023.0.1.x86_64 : A very fast and robust SQL database server
Repo        : amazonlinux
Matched from:
Filename    : /usr/bin/mysql

mariadb105-3:10.5.16-1.amzn2023.0.7.x86_64 : A very fast and robust SQL database server
Repo        : amazonlinux
Matched from:
Filename    : /usr/bin/mysql

mariadb105-3:10.5.18-1.amzn2023.0.1.x86_64 : A very fast and robust SQL database server
Repo        : amazonlinux
Matched from:
Filename    : /usr/bin/mysql

mariadb105-3:10.5.20-1.amzn2023.0.1.x86_64 : A very fast and robust SQL database server
Repo        : amazonlinux
Matched from:
Filename    : /usr/bin/mysql

mariadb105-3:10.5.23-1.amzn2023.0.1.x86_64 : A very fast and robust SQL database server
Repo        : amazonlinux
Matched from:
Filename    : /usr/bin/mysql

mariadb105-3:10.5.25-1.amzn2023.0.1.x86_64 : A very fast and robust SQL database server
Repo        : amazonlinux
Matched from:
Filename    : /usr/bin/mysql

mariadb105-3:10.5.29-1.amzn2023.0.1.x86_64 : A very fast and robust SQL database server
Repo        : amazonlinux
Matched from:
Filename    : /usr/bin/mysql

mariadb114-3:11.4.10-1.amzn2023.0.1.x86_64 : A very fast and robust SQL database server
Repo        : amazonlinux
Matched from:
Filename    : /usr/bin/mysql

[root@ip-172-31-12-10 /]# yum install mariadb105-3:10.5.29-1.amzn2023.0.1.x86_64
Last metadata expiration check: 1:20:58 ago on Sun May 24 05:43:17 2026.
Dependencies resolved.
===========================================================================================================================================================================================
 Package                                               Architecture                      Version                                              Repository                              Size
===========================================================================================================================================================================================
Installing:
 mariadb105                                            x86_64                            3:10.5.29-1.amzn2023.0.1                             amazonlinux                            1.5 M
Installing dependencies:
 mariadb-connector-c                                   x86_64                            3.3.10-1.amzn2023.0.1                                amazonlinux                            211 k
 mariadb-connector-c-config                            noarch                            3.3.10-1.amzn2023.0.1                                amazonlinux                            9.9 k
 mariadb105-common                                     x86_64                            3:10.5.29-1.amzn2023.0.1                             amazonlinux                             28 k
 perl-Sys-Hostname                                     x86_64                            1.23-477.amzn2023.0.8                                amazonlinux                             17 k

Transaction Summary
===========================================================================================================================================================================================
Install  5 Packages

Total download size: 1.8 M
Installed size: 19 M
Is this ok [y/N]: y
Downloading Packages:
(1/5): mariadb-connector-c-3.3.10-1.amzn2023.0.1.x86_64.rpm                                                                                                5.1 MB/s | 211 kB     00:00    
(2/5): mariadb-connector-c-config-3.3.10-1.amzn2023.0.1.noarch.rpm                                                                                         228 kB/s | 9.9 kB     00:00    
(3/5): mariadb105-10.5.29-1.amzn2023.0.1.x86_64.rpm                                                                                                         27 MB/s | 1.5 MB     00:00    
(4/5): mariadb105-common-10.5.29-1.amzn2023.0.1.x86_64.rpm                                                                                                 1.1 MB/s |  28 kB     00:00    
(5/5): perl-Sys-Hostname-1.23-477.amzn2023.0.8.x86_64.rpm                                                                                                  703 kB/s |  17 kB     00:00    
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Total                                                                                                                                                       15 MB/s | 1.8 MB     00:00     
Running transaction check
Transaction check succeeded.
Running transaction test
Transaction test succeeded.
Running transaction
  Preparing        :                                                                                                                                                                   1/1 
  Installing       : mariadb-connector-c-config-3.3.10-1.amzn2023.0.1.noarch                                                                                                           1/5 
  Installing       : mariadb-connector-c-3.3.10-1.amzn2023.0.1.x86_64                                                                                                                  2/5 
  Installing       : mariadb105-common-3:10.5.29-1.amzn2023.0.1.x86_64                                                                                                                 3/5 
  Installing       : perl-Sys-Hostname-1.23-477.amzn2023.0.8.x86_64                                                                                                                    4/5 
  Installing       : mariadb105-3:10.5.29-1.amzn2023.0.1.x86_64                                                                                                                        5/5 
  Running scriptlet: mariadb105-3:10.5.29-1.amzn2023.0.1.x86_64                                                                                                                        5/5 
  Verifying        : mariadb-connector-c-3.3.10-1.amzn2023.0.1.x86_64                                                                                                                  1/5 
  Verifying        : mariadb-connector-c-config-3.3.10-1.amzn2023.0.1.noarch                                                                                                           2/5 
  Verifying        : mariadb105-3:10.5.29-1.amzn2023.0.1.x86_64                                                                                                                        3/5 
  Verifying        : mariadb105-common-3:10.5.29-1.amzn2023.0.1.x86_64                                                                                                                 4/5 
  Verifying        : perl-Sys-Hostname-1.23-477.amzn2023.0.8.x86_64                                                                                                                    5/5 

Installed:
  mariadb-connector-c-3.3.10-1.amzn2023.0.1.x86_64              mariadb-connector-c-config-3.3.10-1.amzn2023.0.1.noarch             mariadb105-3:10.5.29-1.amzn2023.0.1.x86_64            
  mariadb105-common-3:10.5.29-1.amzn2023.0.1.x86_64             perl-Sys-Hostname-1.23-477.amzn2023.0.8.x86_64                     

Complete!
[root@ip-172-31-12-10 /]# 
[root@ip-172-31-12-10 /]# 
[root@ip-172-31-12-10 /]# 
[root@ip-172-31-12-10 /]# mysql -h database-1.cbaw4kes2epe.ap-south-1.rds.amazonaws.com -P 3306 -u admin -p
Enter password: 
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MySQL connection id is 31
Server version: 8.4.8 Source distribution

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MySQL [(none)]> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
4 rows in set (0.029 sec)

MySQL [(none)]> CREATE DATABASE chatdb;
Query OK, 1 row affected (0.039 sec)

MySQL [(none)]> exit
Bye
[root@ip-172-31-12-10 /]# kubectl get namespace
NAME              STATUS   AGE
default           Active   69m
dev               Active   75s
kube-node-lease   Active   69m
kube-public       Active   69m
kube-system       Active   69m
[root@ip-172-31-12-10 /]# kubectl get secret
No resources found in default namespace.
[root@ip-172-31-12-10 /]# kubectl get secret -n dev
NAME        TYPE     DATA   AGE
db-secret   Opaque   1      96s
[root@ip-172-31-12-10 /]# kubectl describe secret -n dev
Name:         db-secret
Namespace:    dev
Labels:       <none>
Annotations:  <none>

Type:  Opaque

Data
====
DATABASE_URL:  88 bytes
[root@ip-172-31-12-10 /]# kubectl get deployment -n dev
NAME                  READY   UP-TO-DATE   AVAILABLE   AGE
multi-chat-backend    2/2     2            2           3m26s
multi-chat-frontend   2/2     2            2           2m50s
[root@ip-172-31-12-10 /]# kubectl get pods -n dev
NAME                                  READY   STATUS    RESTARTS   AGE
multi-chat-backend-8d85ffbfd-b7q65    1/1     Running   0          3m28s
multi-chat-backend-8d85ffbfd-kjhv9    1/1     Running   0          3m34s
multi-chat-frontend-88577b977-kv84n   1/1     Running   0          2m51s
multi-chat-frontend-88577b977-m9kfr   1/1     Running   0          2m58s
[root@ip-172-31-12-10 /]# kubectl get svc -n dev
NAME                          TYPE           CLUSTER-IP       EXTERNAL-IP                                                                PORT(S)          AGE
multi-chat-backend-service    LoadBalancer   10.100.244.162   aa098c12654d64c4489dc55b4d912c62-816645057.ap-south-1.elb.amazonaws.com    5000:30911/TCP   3m58s
multi-chat-frontend-service   LoadBalancer   10.100.118.165   a1a936bb5ffe44f93b1c6b4eda9efd97-1095022099.ap-south-1.elb.amazonaws.com   80:30376/TCP     3m22s
[root@ip-172-31-12-10 /]# kubectl get configmap -n dev
NAME               DATA   AGE
backend-config     1      4m26s
kube-root-ca.crt   1      5m5s
[root@ip-172-31-12-10 /]# kubectl describe  configmap backend-config -n dev
Name:         backend-config
Namespace:    dev
Labels:       <none>
Annotations:  <none>

Data
====
BACKEND_URL:
----
http://aa098c12654d64c4489dc55b4d912c62-816645057.ap-south-1.elb.amazonaws.com:5000
Events:  <none>
[root@ip-172-31-12-10 /]# mysql -h database-1.cbaw4kes2epe.ap-south-1.rds.amazonaws.com -P 3306 -u admin -p
Enter password: 
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MySQL connection id is 45
Server version: 8.4.8 Source distribution

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MySQL [(none)]> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| chatdb             |
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
5 rows in set (0.017 sec)

MySQL [(none)]> USE chatdb;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
MySQL [chatdb]> SHOW TABLES;
+------------------+
| Tables_in_chatdb |
+------------------+
| messages         |
| users            |
+------------------+
2 rows in set (0.002 sec)

MySQL [chatdb]> SELECT * FROM messages;
+----+-----------+----------+---------------------+
| id | username  | message  | timestamp           |
+----+-----------+----------+---------------------+
|  1 | sudhanshu | hi hello | 2026-05-24 07:16:31 |
|  2 | prajval   | Hi       | 2026-05-24 07:17:29 |
|  3 | Prabeesh  | Hello    | 2026-05-24 07:17:56 |
|  4 | gfg       | hi       | 2026-05-24 07:17:58 |
|  5 | sudhanshu | hi       | 2026-05-24 07:18:41 |
+----+-----------+----------+---------------------+
5 rows in set (0.002 sec)

MySQL [chatdb]> select * from users;
+----+-----------+--------------------------------------------------------------+
| id | username  | password                                                     |
+----+-----------+--------------------------------------------------------------+
|  1 | sudhanshu | $2b$10$fI.TH81Mt2pF057EdotpAu2pB/H7CJKmtWtTrBRJYtbHb3pi8sjI2 |
|  2 | prajval   | $2b$10$N5ShUCG/Py6VYERfpw.wPeSzylg44Ijs8TOdccpkOkvcpIUtmzgie |
|  3 | gfg       | $2b$10$mc1hQrFOILLiiWyZi3NzWOvLE9UIfyUdQXY0MKT1yxClllYKgFI5C |
|  4 | Prabeesh  | $2b$10$DEapoDRSiAP6oO8AwzR8y.hU6EpUg/6YeYuLNzvC87uRKYHPLK2Bi |
+----+-----------+--------------------------------------------------------------+
4 rows in set (0.002 sec)

MySQL [chatdb]> exit
Bye
[root@ip-172-31-12-10 /]# kubectl get namespaces
NAME              STATUS   AGE
default           Active   81m
dev               Active   13m
kube-node-lease   Active   81m
kube-public       Active   81m
kube-system       Active   81m
prod              Active   23s
[root@ip-172-31-12-10 /]# kubectl get pods -n prod
NAME                                 READY   STATUS    RESTARTS   AGE
multi-chat-backend-8d85ffbfd-25wk9   1/1     Running   0          28s
multi-chat-backend-8d85ffbfd-szmz2   1/1     Running   0          30s
[root@ip-172-31-12-10 /]# kubectl get pods -n prod
NAME                                  READY   STATUS    RESTARTS   AGE
multi-chat-backend-8d85ffbfd-25wk9    1/1     Running   0          56s
multi-chat-backend-8d85ffbfd-szmz2    1/1     Running   0          58s
multi-chat-frontend-88577b977-jv4zt   1/1     Running   0          24s
multi-chat-frontend-88577b977-knt5p   1/1     Running   0          26s
[root@ip-172-31-12-10 /]# kubectl get svc -n prod
NAME                          TYPE           CLUSTER-IP       EXTERNAL-IP                                                                PORT(S)          AGE
multi-chat-backend-service    LoadBalancer   10.100.34.202    ae47097b4189e450baaa7c273bc962c9-1027852956.ap-south-1.elb.amazonaws.com   5000:31301/TCP   66s
multi-chat-frontend-service   LoadBalancer   10.100.120.180   a545e4378675543168440bba9a9c70a1-3144384.ap-south-1.elb.amazonaws.com      80:30290/TCP     34s
[root@ip-172-31-12-10 /]# kubectl get svc -n dev
NAME                          TYPE           CLUSTER-IP       EXTERNAL-IP                                                                PORT(S)          AGE
multi-chat-backend-service    LoadBalancer   10.100.244.162   aa098c12654d64c4489dc55b4d912c62-816645057.ap-south-1.elb.amazonaws.com    5000:30911/TCP   15m
multi-chat-frontend-service   LoadBalancer   10.100.118.165   a1a936bb5ffe44f93b1c6b4eda9efd97-1095022099.ap-south-1.elb.amazonaws.com   80:30376/TCP     15m
[root@ip-172-31-12-10 /]# kubectl get pods -n dev
NAME                                   READY   STATUS    RESTARTS   AGE
multi-chat-backend-c7b955b76-k5w4q     1/1     Running   0          102s
multi-chat-backend-c7b955b76-z8d6v     1/1     Running   0          108s
multi-chat-frontend-6655dfff99-2hrnd   1/1     Running   0          63s
multi-chat-frontend-6655dfff99-zjcp4   1/1     Running   0          68s
[root@ip-172-31-12-10 /]# kubectl get pods -n prod
NAME                                  READY   STATUS    RESTARTS   AGE
multi-chat-backend-8d85ffbfd-25wk9    1/1     Running   0          11m
multi-chat-backend-8d85ffbfd-szmz2    1/1     Running   0          11m
multi-chat-frontend-88577b977-jv4zt   1/1     Running   0          10m
multi-chat-frontend-88577b977-knt5p   1/1     Running   0          10m
[root@ip-172-31-12-10 /]# kubectl get pods -n prod
NAME                                  READY   STATUS    RESTARTS   AGE
multi-chat-backend-c7b955b76-phzrm    1/1     Running   0          6s
multi-chat-backend-c7b955b76-tn8qr    1/1     Running   0          8s
multi-chat-frontend-88577b977-jv4zt   1/1     Running   0          11m
multi-chat-frontend-88577b977-knt5p   1/1     Running   0          11m
[root@ip-172-31-12-10 /]# 
[root@ip-172-31-12-10 /]# 
[root@ip-172-31-12-10 /]# 
[root@ip-172-31-12-10 /]# yum install ansible -y > /dev/null
[root@ip-172-31-12-10 /]# ansible -version
usage: ansible [-h] [--version] [-v] [-b] [--become-method BECOME_METHOD] [--become-user BECOME_USER] [-K | --become-password-file BECOME_PASSWORD_FILE] [-i INVENTORY] [--list-hosts]
               [-l SUBSET] [-P POLL_INTERVAL] [-B SECONDS] [-o] [-t TREE] [--private-key PRIVATE_KEY_FILE] [-u REMOTE_USER] [-c CONNECTION] [-T TIMEOUT]
               [--ssh-common-args SSH_COMMON_ARGS] [--sftp-extra-args SFTP_EXTRA_ARGS] [--scp-extra-args SCP_EXTRA_ARGS] [--ssh-extra-args SSH_EXTRA_ARGS]
               [-k | --connection-password-file CONNECTION_PASSWORD_FILE] [-C] [-D] [-e EXTRA_VARS] [--vault-id VAULT_IDS]
               [--ask-vault-password | --vault-password-file VAULT_PASSWORD_FILES] [-f FORKS] [-M MODULE_PATH] [--playbook-dir BASEDIR] [--task-timeout TASK_TIMEOUT] [-a MODULE_ARGS]
               [-m MODULE_NAME]
               pattern
ansible: error: the following arguments are required: pattern
 
usage: ansible [-h] [--version] [-v] [-b] [--become-method BECOME_METHOD] [--become-user BECOME_USER] [-K | --become-password-file BECOME_PASSWORD_FILE] [-i INVENTORY] [--list-hosts]
               [-l SUBSET] [-P POLL_INTERVAL] [-B SECONDS] [-o] [-t TREE] [--private-key PRIVATE_KEY_FILE] [-u REMOTE_USER] [-c CONNECTION] [-T TIMEOUT]
               [--ssh-common-args SSH_COMMON_ARGS] [--sftp-extra-args SFTP_EXTRA_ARGS] [--scp-extra-args SCP_EXTRA_ARGS] [--ssh-extra-args SSH_EXTRA_ARGS]
               [-k | --connection-password-file CONNECTION_PASSWORD_FILE] [-C] [-D] [-e EXTRA_VARS] [--vault-id VAULT_IDS]
               [--ask-vault-password | --vault-password-file VAULT_PASSWORD_FILES] [-f FORKS] [-M MODULE_PATH] [--playbook-dir BASEDIR] [--task-timeout TASK_TIMEOUT] [-a MODULE_ARGS]
               [-m MODULE_NAME]
               pattern

Define and run a single task 'playbook' against a set of hosts

positional arguments:
  pattern               host pattern

optional arguments:
  --ask-vault-password, --ask-vault-pass
                        ask for vault password
  --become-password-file BECOME_PASSWORD_FILE, --become-pass-file BECOME_PASSWORD_FILE
                        Become password file
  --connection-password-file CONNECTION_PASSWORD_FILE, --conn-pass-file CONNECTION_PASSWORD_FILE
                        Connection password file
  --list-hosts          outputs a list of matching hosts; does not execute anything else
  --playbook-dir BASEDIR
                        Since this tool does not use playbooks, use this as a substitute playbook directory. This sets the relative path for many features including roles/ group_vars/
                        etc.
  --task-timeout TASK_TIMEOUT
                        set task timeout limit in seconds, must be positive integer.
  --vault-id VAULT_IDS  the vault identity to use
  --vault-password-file VAULT_PASSWORD_FILES, --vault-pass-file VAULT_PASSWORD_FILES
                        vault password file
  --version             show program's version number, config file location, configured module search path, module location, executable location and exit
  -B SECONDS, --background SECONDS
                        run asynchronously, failing after X seconds (default=N/A)
  -C, --check           don't make any changes; instead, try to predict some of the changes that may occur
  -D, --diff            when changing (small) files and templates, show the differences in those files; works great with --check
  -K, --ask-become-pass
                        ask for privilege escalation password
  -M MODULE_PATH, --module-path MODULE_PATH
                        prepend colon-separated path(s) to module library (default={{ ANSIBLE_HOME ~ "/plugins/modules:/usr/share/ansible/plugins/modules" }})
  -P POLL_INTERVAL, --poll POLL_INTERVAL
                        set the poll interval if using -B (default=15)
  -a MODULE_ARGS, --args MODULE_ARGS
                        The action's options in space separated k=v format: -a 'opt1=val1 opt2=val2' or a json string: -a '{"opt1": "val1", "opt2": "val2"}'
  -e EXTRA_VARS, --extra-vars EXTRA_VARS
                        set additional variables as key=value or YAML/JSON, if filename prepend with @
  -f FORKS, --forks FORKS
                        specify number of parallel processes to use (default=5)
  -h, --help            show this help message and exit
  -i INVENTORY, --inventory INVENTORY, --inventory-file INVENTORY
                        specify inventory host path or comma separated host list. --inventory-file is deprecated
  -k, --ask-pass        ask for connection password
  -l SUBSET, --limit SUBSET
                        further limit selected hosts to an additional pattern
  -m MODULE_NAME, --module-name MODULE_NAME
                        Name of the action to execute (default=command)
  -o, --one-line        condense output
  -t TREE, --tree TREE  log output to this directory
  -v, --verbose         Causes Ansible to print more debug messages. Adding multiple -v will increase the verbosity, the builtin plugins currently evaluate up to -vvvvvv. A reasonable
                        level to start is -vvv, connection debugging might require -vvvv.

Privilege Escalation Options:
  control how and which user you become as on target hosts

  --become-method BECOME_METHOD
                        privilege escalation method to use (default=sudo), use `ansible-doc -t become -l` to list valid choices.
  --become-user BECOME_USER
                        run operations as this user (default=root)
  -b, --become          run operations with become (does not imply password prompting)

Connection Options:
  control as whom and how to connect to hosts

  --private-key PRIVATE_KEY_FILE, --key-file PRIVATE_KEY_FILE
                        use this file to authenticate the connection
  --scp-extra-args SCP_EXTRA_ARGS
                        specify extra arguments to pass to scp only (e.g. -l)
  --sftp-extra-args SFTP_EXTRA_ARGS
                        specify extra arguments to pass to sftp only (e.g. -f, -l)
  --ssh-common-args SSH_COMMON_ARGS
                        specify common arguments to pass to sftp/scp/ssh (e.g. ProxyCommand)
  --ssh-extra-args SSH_EXTRA_ARGS
                        specify extra arguments to pass to ssh only (e.g. -R)
  -T TIMEOUT, --timeout TIMEOUT
                        override the connection timeout in seconds (default=10)
  -c CONNECTION, --connection CONNECTION
                        connection type to use (default=smart)
  -u REMOTE_USER, --user REMOTE_USER
                        connect as this user (default=None)

Some actions do not make sense in Ad-Hoc (include, meta, etc)
[root@ip-172-31-12-10 /]# ansible --version
ansible [core 2.15.3]
  config file = None
  configured module search path = ['/root/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3.9/site-packages/ansible
  ansible collection location = /root/.ansible/collections:/usr/share/ansible/collections
  executable location = /usr/bin/ansible
  python version = 3.9.25 (main, Apr 17 2026, 00:00:00) [GCC 11.5.0 20240719 (Red Hat 11.5.0-5)] (/usr/bin/python3.9)
  jinja version = 3.1.4
  libyaml = True
[root@ip-172-31-12-10 /]# $ ansible-config init --disabled > ansible.cfg
bash: $: command not found
[root@ip-172-31-12-10 /]# ansible-config init --disabled > ansible.cfg
[root@ip-172-31-12-10 /]# vi ansible.cfg 
[root@ip-172-31-12-10 /]# vi inventory
[root@ip-172-31-12-10 /]# history
    1  cd /
    2  yum install docker -y
    3  systemctl start docker
    4  docker run -p 8080:8080 -p 50000:50000 --name jenkins -dit --restart=on-failure -v jenkins_home:/var/jenkins_home jenkins/jenkins:lts-jdk21
    5  docker ps
    6  docker exec -it jenkins cat /var/jenkins_home/secrets/initialAdminPassword
    7  wget https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.rpm
    8  yum install jdk-21_linux-x64_bin.rpm -y
    9  yum install git -y
   10  sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
   11  sudo chmod +x /usr/local/bin/docker-compose
   12  docker-compose --version
   13  vi docker-compose.yml
   14  docker-compose up -d
   15  mkdir /data
   16  curl -sO http://65.0.183.40:8080/jnlpJars/agent.jar
   17  java -jar agent.jar -url http://65.0.183.40:8080/ -secret 272e1cc17d5f828833d3519f8d1f4647e0b78b160e962c582b71b57e3ff46afe -name ec2 -webSocket -workDir "/data"
   18  curl -sO http://65.0.183.40:8080/jnlpJars/agent.jar
   19  java -jar agent.jar -url http://65.0.183.40:8080/ -secret 272e1cc17d5f828833d3519f8d1f4647e0b78b160e962c582b71b57e3ff46afe -name ec2 -webSocket -workDir "/data" &
   20  docker-compose ps
   21  docker ps
   22  aws configure
   23  clear
   24  docker ps
   25  curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
   26  sudo mv /tmp/eksctl /usr/local/bin
   27  eksctl version
   28  curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.19.6/2021-01-05/bin/linux/amd64/kubectl
   29  chmod +x ./kubectl
   30  sudo mv ./kubectl /usr/local/bin
   31  kubectl version --short --client
   32  eksctl create cluster --name EKSCHAT --region ap-south-1 --vpc-public-subnets=subnet-0e64ffc947ac8929c,subnet-04c1ed6ba9c55ffd7 --nodegroup-name default-ng --node-type t3.medium --nodes=2 --nodes-min=2 --nodes-max=2 --node-volume-size=20 --ssh-access --ssh-public-key DevOps --managed
   33  kubectl get pods
   34  kubectl get pods -n kube-system
   35  mysql -h database-1.cbaw4kes2epe.ap-south-1.rds.amazonaws.com -P 3306 -u admin -p
   36  yum whatrpovides mysql
   37  yum whatprovides mysql
   38  yum install mariadb105-3:10.5.29-1.amzn2023.0.1.x86_64
   39  mysql -h database-1.cbaw4kes2epe.ap-south-1.rds.amazonaws.com -P 3306 -u admin -p
   40  kubectl get namespace
   41  kubectl get secret
   42  kubectl get secret -n dev
   43  kubectl describe secret -n dev
   44  kubectl get deployment -n dev
   45  kubectl get pods -n dev
   46  kubectl get svc -n dev
   47  kubectl get configmap -n dev
   48  kubectl describe  configmap backend-config -n dev
   49  mysql -h database-1.cbaw4kes2epe.ap-south-1.rds.amazonaws.com -P 3306 -u admin -p
   50  kubectl get namespaces
   51  kubectl get pods -n prod
   52  kubectl get pods -n prod
   53  kubectl get svc -n prod
   54  kubectl get svc -n dev
   55  kubectl get pods -n dev
   56  kubectl get pods -n prod
   57  kubectl get pods -n prod
   58  yum install ansible -y > /dev/null
   59  ansible -version
   60  ansible --version
   61  $ ansible-config init --disabled > ansible.cfg
   62  ansible-config init --disabled > ansible.cfg
   63  vi ansible.cfg 
   64  vi inventory
   65  history
[root@ip-172-31-12-10 /]# eksctl delete cluster EKSCHAT --region ap-south-1
2026-05-24 08:03:13 [ℹ]  deleting EKS cluster "EKSCHAT"
2026-05-24 08:03:13 [ℹ]  will drain 0 unmanaged nodegroup(s) in cluster "EKSCHAT"
2026-05-24 08:03:13 [ℹ]  starting parallel draining, max in-flight of 1
2026-05-24 08:03:14 [ℹ]  deleted 0 Fargate profile(s)
2026-05-24 08:03:14 [✔]  kubeconfig has been updated
2026-05-24 08:03:14 [ℹ]  cleaning up AWS load balancers created by Kubernetes objects of Kind Service, Ingress, or Gateway