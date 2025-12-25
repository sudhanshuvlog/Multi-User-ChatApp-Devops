pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials')
        MYSQL_CONNECTION_STRING = credentials('mysql-connection-string')
        KUBECONFIG = credentials('kubeconfig')
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/sudhanshuvlog/Multi-User-ChatApp-Devops.git'
            }
        }

        stage('Create Secrets') {
            steps {
                sh '''
                kubectl create secret generic db-secret --from-literal=DATABASE_URL=$MYSQL_CONNECTION_STRING --dry-run=client -o yaml | kubectl apply -f -
                '''
            }
        }

        stage('Deploy to EKS') {
            steps {
                sh '''
                kubectl apply -f k8s/
                '''
            }
        }
    }

    post {
        always {
            sh 'kubectl get pods'
        }
    }
}