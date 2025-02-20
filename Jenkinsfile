def APP_VERSION = ''

pipeline {
    agent any
    environment {
        BUILD_DIR = '/tmp/build'  // Directorio compartido para almacenar el .jar generado
    }
    stages {
        stage('Test') {
            agent {
                label 'mvn-agent'
            }
            steps {
                sh 'mvn test'
            }
        }
        stage('Build') {
            agent {
                label 'mvn-agent'
            }
            steps {
                sh 'mvn clean install'
                sh "cp target/*.jar ${env.BUILD_DIR}/app.jar"
                sh "mvn help:evaluate -Dexpression=project.version -q -DforceStdout > version.txt"
                script {
                    APP_VERSION = readFile('version.txt').trim()
                }
            }
        }
        stage('Deploy') {
            agent {
                label 'docker-agent'
            }
            steps {
                 sh "cp ${env.BUILD_DIR}/app.jar ."
                 sh "docker build -t my-app-image:${APP_VERSION} ."
            }
        }
    }
}
