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
                sh 'mvn test'
            }
        }
        stage('Build') {
            agent {
                label 'agent-mvn'
            }
            steps {
                 sh 'mvn clean install'
            }
        }
        stage('Deploy') {
            agent {
                label 'agent-docker'
            }
            steps {
                 sh 'docker ps'
            }
        }
    }
}
