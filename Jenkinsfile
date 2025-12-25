pipeline {
    agent { label 'ec2' } 

    environment {
        TAG = sh(script: 'git rev-parse HEAD', returnStdout: true).trim()
        MYSQL_CONNECTION_STRING = credentials('mysql-connection-string')
    }

    stages {
        stage('Create Secrets') {
            steps {
                sh '''
                kubectl create secret generic db-secret --from-literal=DATABASE_URL=$MYSQL_CONNECTION_STRING --dry-run=client -o yaml | kubectl apply -f -
                '''
            }
        }

        stage('Deploy Backend') {
            steps {
                sh '''
                sed -i "s|latest|${TAG}|g" k8s/backend-deployment.yaml
                kubectl apply -f k8s/backend-deployment.yaml
                kubectl rollout status deployment/multi-chat-backend
                '''
            }
        }

        stage('Get Backend URL and Create ConfigMap') {
            steps {
                script {
                    def backendUrl = sh(
                        script: "kubectl get svc multi-chat-backend-service -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'",
                        returnStdout: true
                    ).trim()
                    sh """
                    kubectl create configmap backend-config --from-literal=BACKEND_URL=http://${backendUrl}:5000 --dry-run=client -o yaml | kubectl apply -f -
                    """
                }
            }
        }

        stage('Deploy Frontend') {
            steps {
                sh '''
                sed -i "s|latest|${TAG}|g" k8s/frontend-deployment.yaml
                kubectl apply -f k8s/frontend-deployment.yaml

                '''
            }
        }
    }
}