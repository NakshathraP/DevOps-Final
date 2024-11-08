pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'my-maven-app'
        DOCKER_TAG = 'latest'  // Tag for the Docker image
    }

    stages {
        stage('Checkout') {
            steps {
                // Pull the latest code from the Git repository
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image locally
                    sh 'docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} .'
                }
            }
        }

        stage('Deploy Docker Container') {
            steps {
                script {
                    // Check if a container is already running
                    def existingContainer = sh(script: "docker ps -q -f name=${DOCKER_IMAGE}", returnStdout: true).trim()

                    if (existingContainer) {
                        // Stop and remove the existing container
                        sh "docker stop ${existingContainer}"
                        sh "docker rm ${existingContainer}"
                    }

                    // Run the container with port mappings
                    sh "docker run -d -p 8081:8080 --name ${DOCKER_IMAGE} ${DOCKER_IMAGE}:${DOCKER_TAG}"
                }
            }
        }
    }

    post {
        always {
            // Clean up any leftover Docker images (optional)
            sh 'docker system prune -f'
        }
    }
}
