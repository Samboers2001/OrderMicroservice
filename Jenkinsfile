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
                    dir('/Users/samboers/development/order_management_system/OrderMicroservice') {
                        sh 'docker build -t samboers/ordermicroservice .'
                    }
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
                    dir('/Users/samboers/development/order_management_system/OrderMicroservice/K8S/Local/order-database') {
                        sh 'kubectl apply -f mariadb-order-secret.yaml'
                        sh 'kubectl apply -f mariadb-order-claim.yaml'
                        sh 'kubectl apply -f mariadb-order-depl.yaml'
                    }
                }
            }
        }

        stage('Deploy OrderMicroservice to Kubernetes') {
            steps {
                script {
                    dir('/Users/samboers/development/order_management_system/OrderMicroservice/K8S/Local/order-service') {
                        sh 'kubectl apply -f order-depl.yaml'
                        sh 'kubectl apply -f order-service-hpa.yaml'
                    }
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


        stage('Wait for Deployment to be Ready') {
            steps {
                script {
                    dir('/Users/samboers/development/order_management_system/OrderMicroservice') {
                        sh 'kubectl wait --for=condition=available --timeout=60s deployment/order-depl'
                    }
                }
            }
        }

        stage('Load Testing') {
            steps {
                script {
                    sh 'rm -f /Users/samboers/JMeter/OrderLoadTestresults.csv'
                    sh 'rm -rf /Users/samboers/JMeter/OrderHtmlReport/*' 
                    sh 'mkdir -p /Users/samboers/JMeter/OrderHtmlReport'
                    sh '/opt/homebrew/bin/jmeter -n -t /Users/samboers/JMeter/LoginThenOrderLoadTest.jmx -l /Users/samboers/JMeter/OrderLoadTestresults.csv -e -o /Users/samboers/JMeter/OrderHtmlReport'
                }
            }
        }

    }

}
