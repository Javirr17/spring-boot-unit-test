pipeline {
    agent any
    triggers {
        pollSCM '* * * * *'
    }
    environment {
        BUILD_DIR = '/tmp/build'  // Directorio compartido para almacenar el .jar generado
        APP_VERSION = ''
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
                script {
                    env.APP_VERSION = sh(script: "mvn help:evaluate -Dexpression=project.version -q -DforceStdout", returnStdout: true).trim()
                    echo "Project Version: ${env.APP_VERSION}"
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
                 sh "docker build -t my-app-image:${env.APP_VERSION} ."
            }
        }
    }
}
