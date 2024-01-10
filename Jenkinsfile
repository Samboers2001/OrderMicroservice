pipeline {
    agent any 
    
    environment {
        PATH = "/usr/local/bin:/Users/samboers/google-cloud-sdk/bin:$PATH"
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/Samboers2001/OrderMicroservice'
            }
        }

        stage('Checkout Test Project') {
            steps {
                git 'https://github.com/Samboers2001/OrderMicroservice.Tests'
            }
        }

        stage('Restore and Test') {
            steps {
                script {
                    dir('/Users/samboers/development/order_management_system/OrderMicroservice.Tests') {
                        sh '/usr/local/share/dotnet/dotnet restore'
                        sh '/usr/local/share/dotnet/dotnet test'
                    }
                }
            }
        }


        stage('Build docker image') {
            steps {
                script {
                    sh 'docker build -t samboers/ordermicroservice .'
                }
            }
        }
        
        stage('Push to dockerhub') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'dockerhubpasswordcorrect', variable: 'dockerhubpwd')]) {
                        sh 'docker login -u samboers -p ${dockerhubpwd}'
                        sh 'docker push samboers/ordermicroservice'
                    }
                }
            }
        }

        stage('Deploy Database to Kubernetes') {
            steps {
                script {
                    sh 'kubectl apply -f K8S/Local/order-database/mariadb-order-secret.yaml'
                    sh 'kubectl apply -f K8S/Local/order-database/mariadb-order-claim.yaml' 
                    sh 'kubectl apply -f K8S/Local/order-database/mariadb-order-depl.yaml'
                }
            }
        }

        stage('Deploy AccountMicroservice to Kubernetes') {
            steps {
                script {
                    sh 'kubectl apply -f K8S/Local/order-service/order-depl.yaml'
                    sh 'kubectl apply -f K8S/Local/order-service/order-service-hpa.yaml'
                }
            }
        }

        stage('Rollout Restart') {
            steps {
                script {
                    sh 'kubectl rollout restart deployment order-depl'
                }
            }
        }
    }
}
