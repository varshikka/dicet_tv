pipeline {
    agent {label 'dev'}
    tools {maven 'maven'}
    stages {
        stage ('Git') {
            steps {
                git 'https://github.com/vamsibyramala/dicet_tv.git'
            }
        }
        stage ('build') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage ('deploy') {
            steps {
                deploy adapters: [tomcat9(alternativeDeploymentContext: '', credentialsId: 'tomcat', path: '', url: 'http://3.111.55.62:8080/')], contextPath: 'test', war: '**/*.war'
            }
        }
    }
}
