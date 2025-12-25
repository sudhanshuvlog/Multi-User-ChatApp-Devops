pipeline {
    agent { label 'ec2' }

    parameters {
        choice(name: 'ENVIRONMENT', choices: ['dev', 'staging', 'prod'], description: 'Select deployment environment')
        booleanParam(name: 'FORCE_PROD_DEPLOYMENT', defaultValue: false, description: 'Force deployment to production (admin only)')
    }

    environment {
        TAG = sh(script: 'git rev-parse HEAD', returnStdout: true).trim()
        MYSQL_CONNECTION_STRING = credentials('mysql-connection-string')
        NAMESPACE = "${params.ENVIRONMENT}"
        SERVICE_TYPE = 'LoadBalancer'
        IS_PROD_DEPLOYMENT = "${params.ENVIRONMENT == 'prod' || params.FORCE_PROD_DEPLOYMENT}"
    }

    stages {
        stage('Validate Production Deployment') {
            when {
                expression { IS_PROD_DEPLOYMENT == 'true' }
            }
            steps {
                script {
                    echo "PRODUCTION DEPLOYMENT DETECTED"
                    echo "Environment: ${NAMESPACE}"
                    echo "Build: ${BUILD_NUMBER}"
                    echo "Tag: ${TAG}"
                    
                    // Add approval for production deployments
                    timeout(time: 15, unit: 'MINUTES') {
                        input message: 'Deploy to Production?', 
                              ok: 'Deploy',
                              submitterParameter: 'APPROVER'
                    }
                }
            }
        }

        stage('Create Namespace') {
            steps {
                sh "kubectl create namespace ${NAMESPACE} --dry-run=client -o yaml | kubectl apply -f -"
            }
        }

        stage('Create Secrets') {
            steps {
                sh """
                kubectl create secret generic db-secret --from-literal=DATABASE_URL=$MYSQL_CONNECTION_STRING --namespace=${NAMESPACE} --dry-run=client -o yaml | kubectl apply -f -
                """
            }
        }

        stage('Deploy Backend') {
            steps {
                sh """
                sed -i "s|latest|${TAG}|g" k8s/backend-deployment.yaml
                sed -i "s|LoadBalancer|${SERVICE_TYPE}|g" k8s/backend-deployment.yaml
                kubectl apply -f k8s/backend-deployment.yaml --namespace=${NAMESPACE}
                kubectl rollout status deployment/multi-chat-backend --namespace=${NAMESPACE}
                """
            }
        }

        stage('Get Backend URL and Create ConfigMap') {
            steps {
                script {
                    if (SERVICE_TYPE == 'LoadBalancer') {
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
        }

        stage('Deploy Frontend') {
            steps {
                sh """
                sed -i "s|latest|${TAG}|g" k8s/frontend-deployment.yaml
                sed -i "s|LoadBalancer|${SERVICE_TYPE}|g" k8s/frontend-deployment.yaml
                kubectl apply -f k8s/frontend-deployment.yaml --namespace=${NAMESPACE}
                """
            }
        }
    }
}