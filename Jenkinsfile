def APP_VERSION = ''

pipeline {
    agent any
    triggers {
        pollSCM '* * * * *'
    }
    environment {
        BUILD_DIR = '/tmp/build'  // Directorio compartido para almacenar el .jar generado
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
                sh "mvn help:evaluate -Dexpression=project.version -q -DforceStdout > version.txt"
                script {
                    APP_VERSION = readFile('version.txt').trim()
                }
            }
        }
        stage('Deploy') {
            agent {
                label 'agent-docker'
            }
            steps {
                 sh "cp ${env.BUILD_DIR}/app.jar ."
                 echo "Commit ID: ${env.GIT_COMMIT}"
                 sh "docker build -t my-app-image:${APP_VERSION} ."
            }
        }
    }
}
