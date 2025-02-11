pipeline {
    agent any
    triggers {
        pollSCM '* * * * *'
    }
    stages {
        stage('Build') {
            agent {
                label 'agent-mvn'
            }
            steps {
                mvn clean
            }
        }
        stage('Test') {
            agent {
                label 'agent-mvn'
            }
            steps {
                mvn test
            }
        }
        stage('Deploy') {
            agent {
                label 'agent-docker'
            }
            steps {
                docker ps
            }
        }
    }
}
