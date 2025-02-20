def APP_VERSION = ''
def JAR_NAME = ''

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
                sh "ls target/*.jar > name.txt"
                script {
                    JAR_NAME = readFile('name.txt').trim()
                }
                sh "cp target/${JAR_NAME} ${env.BUILD_DIR}/${JAR_NAME}"
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
                 sh "mv ${env.BUILD_DIR}/${JAR_NAME} app.jar"
                 sh "docker build -t my-app-image:${APP_VERSION} ."
            }
        }
    }
}
