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
                sh "ls target/*.jar | xargs -n 1 basename > name.txt"
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
                 withCredentials([usernamePassword(credentialsId: 'nexus-cred', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                     sh "echo $DOCKER_PASS | docker login http://mynexus.com:8090 -u $DOCKER_USER --password-stdin"
                 }
                 sh "docker tag my-app-image:${APP_VERSION} mynexus.com:8090/my-app-image:${APP_VERSION}"
                 sh "docker push mynexus.com:8090/my-app-image:${APP_VERSION}"
                 sh "docker logout http://mynexus.com:8090"
                 sh "docker rmi my-app-image:${APP_VERSION} --force"
                 sh "docker rmi mynexus.com:8090/my-app-image:${APP_VERSION} --force"
            }
        }
    }
}
