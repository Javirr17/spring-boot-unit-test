pipeline {
    agent any
    triggers {
        pollSCM '* * * * *'
    }
    stages {
        stage('Test') {
            agent {
                label 'agent-mvn'
            }
            steps {
                mvn test
            }
        }
        stage('Build') {
            agent {
                label 'agent-mvn'
            }
            steps {
                mvn clean install
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
