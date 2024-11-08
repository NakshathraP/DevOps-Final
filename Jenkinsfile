pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'my-maven-app'
    }

    stages {

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t ${DOCKER_IMAGE} .'
                }
            }
        }

        stage('Deploy Docker Container') {
            steps {
                script {
                    // Stop and remove any existing container with the same name
                    def existingContainer = sh(script: "docker ps -q -f name=${DOCKER_IMAGE}", returnStdout: true).trim()
                    if (existingContainer) {
                        sh "docker stop ${DOCKER_IMAGE}"
                        sh "docker rm ${DOCKER_IMAGE}"
                    }

                    // Run the container
                    sh "docker run ${DOCKER_IMAGE}"
                }
            }
        }

        stage('Show Container Logs') {
            steps {
                script {
                    // Capture and display the logs of the container
                    sh "docker logs ${DOCKER_IMAGE}"
                }
            }
        }
    }

}
