pipeline {
    agent { label 'dev' }
    tools { maven 'maven' }

    stages {
        stage('SCM') {
            steps {
                git 'https://github.com/vamsibyramala/dicet_tv.git'
            }
        }
        stage('build') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('deploy') {
            steps {
                deploy adapters: [tomcat9(credentialsId: 'tomcat', path: '', url: 'http://13.201.33.52:8080/')], contextPath: 'vamsi', war: '**/*.war'
            }
        }
    }
}
