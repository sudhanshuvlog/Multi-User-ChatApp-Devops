pipeline {
    agent { label 'ec2' }

    parameters {
        choice(
            name: 'ENVIRONMENT',
            choices: ['dev', 'prod'],
            description: 'Select deployment environment'
        )

        booleanParam(
            name: 'FORCE_PROD_DEPLOYMENT',
            defaultValue: false,
            description: 'Force deployment to production (admin only)'
        )
    }

    environment {
        NAMESPACE = "${params.ENVIRONMENT}"
        IS_PROD = "${params.ENVIRONMENT == 'prod' || params.FORCE_PROD_DEPLOYMENT}"
    }

    stages {

        stage('Checkout Code & Set Image Tag') {
            steps {
                checkout scm
                script {
                    // Pick the commit ID as the image tag
                    env.IMAGE_TAG = sh(script: "git rev-parse HEAD", returnStdout: true).trim()
                    env.BACKEND_IMAGE  = "jinny1/multi-chat-backend:${env.IMAGE_TAG}"
                    env.FRONTEND_IMAGE = "jinny1/multi-chat-frontend:${env.IMAGE_TAG}"
                    echo "Using IMAGE_TAG=${env.IMAGE_TAG}"
                }
            }
        }

        stage('Validate Production Deployment') {
            when {
                expression { IS_PROD == 'true' }
            }
            steps {
                script {
                    echo "🚨 PRODUCTION DEPLOYMENT 🚨"
                    echo "Environment : ${NAMESPACE}"
                    echo "Image Tag   : ${env.IMAGE_TAG}"
                    echo "Build       : ${BUILD_NUMBER}"

                    timeout(time: 1, unit: 'HOURS') {
                        input message: 'Approve PRODUCTION deployment?',
                              ok: 'Deploy',
                              submitterParameter: 'APPROVER'
                    }
                }
            }
        }

        stage('Create Namespace') {
            steps {
                sh """
                kubectl create namespace ${NAMESPACE} \
                  --dry-run=client -o yaml | kubectl apply -f -
                """
            }
        }

        stage('Create / Update Secrets') {
            steps {
                withCredentials([
                    string(credentialsId: 'mysql-connection-string', variable: 'DB_URL')
                ]) {
                    sh """
                    kubectl create secret generic db-secret \
                      --from-literal=DATABASE_URL=$DB_URL \
                      --namespace=${NAMESPACE} \
                      --dry-run=client -o yaml | kubectl apply -f -
                    """
                }
            }
        }

        stage('Deploy Backend') {
            steps {
                sh """
                kubectl apply -f k8s/backend-deployment.yaml -n ${NAMESPACE}

                kubectl set image deployment/multi-chat-backend \
                  backend=${BACKEND_IMAGE} \
                  -n ${NAMESPACE}

                kubectl rollout status deployment/multi-chat-backend -n ${NAMESPACE}
                """
            }
        }

        stage('Get Backend URL and Create ConfigMap') {
            steps {
                script {
                        def backendHost = sh(script: "kubectl get svc multi-chat-backend-service -o jsonpath='{.status.loadBalancer.ingress[0].hostname}' --namespace=${NAMESPACE}", returnStdout: true).trim()
                        if (!backendHost) {
                            backendHost = sh(script: "kubectl get svc multi-chat-backend-service -o jsonpath='{.status.loadBalancer.ingress[0].ip}' --namespace=${NAMESPACE}", returnStdout: true).trim()
                        }
                        if (!backendHost) {
                            error "Could not determine backend LoadBalancer host/IP for service 'multi-chat-backend-service' in namespace ${NAMESPACE}"
                        }
                        sh """
                        kubectl create configmap backend-config --from-literal=BACKEND_URL=http://${backendHost}:5000 --namespace=${NAMESPACE} --dry-run=client -o yaml | kubectl apply -f -
                        """
                    
                }
            }
        }

        stage('Deploy Frontend') {
            steps {
                sh """
                kubectl apply -f k8s/frontend-deployment.yaml -n ${NAMESPACE}

                kubectl set image deployment/multi-chat-frontend \
                  frontend=${FRONTEND_IMAGE} \
                  -n ${NAMESPACE}

                kubectl rollout status deployment/multi-chat-frontend -n ${NAMESPACE}
                """
            }
        }
    }

    post {
        success {
            echo "Deployment successful"
        }
        failure {
            echo "❌ Deployment failed"
        }
    }
}
