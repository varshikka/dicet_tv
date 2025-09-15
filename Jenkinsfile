pipeline {
    agent {label 'dev'}
    tools {maven 'maven'}
    stages {
        stage('Git') {
            steps {
                git 'https://github.com/vamsibyramala/dicet_tv.git'
            }
        }
        stage('build') {
            steps {
                sh 'mvn clean package'
            }
        }
    }
}
