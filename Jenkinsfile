pipeline {
    agent {label 'dev'}
    tools {maven 'maven'}

    stages {
        stage('Git') {
            steps {
                git 'https://github.com/vamsibyramala/dicet_tv.git'
            }
        }
        stage('maven'){
            steps {
                sh 'mvn clean package'
            }
        }
        stage('deploy') {
            steps {
                deploy adapters: [tomcat9(credentialsId: 'tomcat', path: '', url: 'http://3.108.219.213:8080/')], contextPath: 'test', war: '**/*.war'
            }
        }
    }
}
