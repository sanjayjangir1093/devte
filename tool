pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/mycompany/myrepo.git'
            }
        }
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('Push') {
            steps {
                input 'Approve push to registry?'
                sh 'docker push myregistry/myimage:latest'
            }
        }
        stage('Deploy') {
            steps {
                input 'Approve deployment to production?'
                sh 'kubectl apply -f deployment.yaml'
            }
        }
    }
}
