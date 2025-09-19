pipeline {
    agent any
    tools {
        maven 'maven'
        jdk 'java'
    }
    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/varshikka/dicet_tv.git', branch: 'master'
            }
        }
        stage('Build with Maven') {
    steps {
        sh '''
        export MAVEN_OPTS="-Dorg.jenkinsci.plugins.durabletask.BourneShellScript.HEARTBEAT_CHECK_INTERVAL=86400"
        mvn clean install
        '''
    }
}
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('sonarqube') {
                    sh 'mvn sonar:sonar -Dsonar.projectKey=squ_5e06bd1491415feb2c03b5132c2676d3386d7663'
                }
            }
        }
        stage('Quality Gate') {
            steps {
                timeout(time: 1, unit: 'HOURS') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }
    }
}


