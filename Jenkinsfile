pipeline {
    agent any
    triggers {
        pollSCM '* * * * *'
    }
    environment {
        // Directorio compartido entre los agentes (puedes usar cualquier directorio)
        BUILD_DIR = '/tmp'  // Directorio temporal para almacenar el .jar generado
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
                 sh "cp target/*.jar ${env.BUILD_DIR}/app.jar"
            }
        }
        stage('Deploy') {
            agent {
                label 'agent-docker'
            }
            steps {
                 sh 'docker build -t my-app-image .'
            }
        }
    }
}
