pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/mariantom/DevOpsClassCodes', branch: 'master'
            }
        }
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t mariantom/mariaimgaddbook:latest .'
            }
        }
        stage('Docker Login and Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-pwd', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                    sh 'echo $PASS | docker login -u $USER --password-stdin'
                    sh 'docker push mariantom/mariaimgaddbook:latest'
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    def dockerCmd = 'docker run -itd --name My-first-containe211 -p 80:8082 mariantom/mariaimgaddbook:latest'
                    sshagent(['sshkeypair']) {
                        sh "ssh -o StrictHostKeyChecking=no ubuntu@172-31-22-46 ${dockerCmd}"
                    }
                }
            }
        }
    }
}
