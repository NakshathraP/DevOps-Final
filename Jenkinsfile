pipeline {
    agent any
    environment {
        DOCKER_IMAGE = 'my-maven-app'
        DOCKER_TAG = 'latest'
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    sh 'mvn clean package'
                    sh 'docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} .'
                }
            }
        }
        stage('Deploy Docker Container') {
            steps {
                script {
                    def existingContainer = sh(script: "docker ps -q -f name=${DOCKER_IMAGE}", returnStdout: true).trim()
                    if (existingContainer) {
                        sh "docker stop ${DOCKER_IMAGE}"
                        sh "docker rm ${DOCKER_IMAGE}"
                    }
                    sh "docker run -d --name ${DOCKER_IMAGE} ${DOCKER_IMAGE}:${DOCKER_TAG}"
                }
            }
        }
        stage('Show Container Logs') {
            steps {
                script { 
                    sh "docker logs ${DOCKER_IMAGE}"
                }
            }
        }
    }
    post {
        always {
            sh 'docker system prune -f'
        }
    }
}
