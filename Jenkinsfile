pipeline {
    agent { label 'ec2' }

    parameters {
        choice(
            name: 'ENVIRONMENT',
            choices: ['dev', 'prod'],
            description: 'Select deployment environment'
        )

        string(
            name: 'IMAGE_TAG',
            description: 'Docker image tag (GitHub SHA)'
        )

        booleanParam(
            name: 'FORCE_PROD_DEPLOYMENT',
            defaultValue: false,
            description: 'Force deployment to production (admin only)'
        )
    }

    environment {
        NAMESPACE = "${params.ENVIRONMENT}"
        BACKEND_IMAGE  = "jinny1/multi-chat-backend:${params.IMAGE_TAG}"
        FRONTEND_IMAGE = "jinny1/multi-chat-frontend:${params.IMAGE_TAG}"
        IS_PROD = "${params.ENVIRONMENT == 'prod' || params.FORCE_PROD_DEPLOYMENT}"
    }

    stages {

        stage('Validate Production Deployment') {
            when {
                expression { IS_PROD == 'true' }
            }
            steps {
                script {
                    echo "🚨 PRODUCTION DEPLOYMENT 🚨"
                    echo "Environment : ${NAMESPACE}"
                    echo "Image Tag   : ${params.IMAGE_TAG}"
                    echo "Build       : ${BUILD_NUMBER}"

                    timeout(time: 15, unit: 'MINUTES') {
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
            echo "Deployment failed"
        }
    }
}
