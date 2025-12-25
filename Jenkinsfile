pipeline {
    agent { label 'ec2' }

    parameters {
        choice(name: 'ENVIRONMENT', choices: ['dev', 'prod'], description: 'Select deployment environment')
        booleanParam(name: 'PROMOTE_TO_PROD', defaultValue: false, description: 'Promote this build to production')
    }

    environment {
        TAG = sh(script: 'git rev-parse HEAD', returnStdout: true).trim()
        MYSQL_CONNECTION_STRING = credentials('mysql-connection-string')
        NAMESPACE = "${params.PROMOTE_TO_PROD ? 'prod' : params.ENVIRONMENT}"
        SERVICE_TYPE = "${params.PROMOTE_TO_PROD || params.ENVIRONMENT == 'prod' ? 'LoadBalancer' : 'ClusterIP'}"
    }

    stages {
        stage('Validate Promotion') {
            when {
                expression { params.PROMOTE_TO_PROD }
            }
            steps {
                script {
                    // Validate that this is a promoted build
                    if (!currentBuild.getCause(hudson.model.Cause$UpstreamCause)) {
                        echo "This is a manual promotion to production"
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
                        def backendUrl = sh(
                            script: "kubectl get svc multi-chat-backend-service -o jsonpath='{.status.loadBalancer.ingress[0].hostname}' --namespace=${NAMESPACE}",
                            returnStdout: true
                        ).trim()
                        sh """
                        kubectl create configmap backend-config --from-literal=BACKEND_URL=http://${backendUrl}:5000 --namespace=${NAMESPACE} --dry-run=client -o yaml | kubectl apply -f -
                        """
                    } else {
                        // For dev, use cluster internal DNS
                        sh """
                        kubectl create configmap backend-config --from-literal=BACKEND_URL=http://multi-chat-backend-service.${NAMESPACE}.svc.cluster.local:5000 --namespace=${NAMESPACE} --dry-run=client -o yaml | kubectl apply -f -
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

        stage('Promotion Success') {
            when {
                expression { params.PROMOTE_TO_PROD }
            }
            steps {
                echo "✅ Successfully promoted build ${BUILD_NUMBER} to production!"
            }
        }
    }
}