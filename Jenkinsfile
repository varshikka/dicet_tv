pipeline {
    agent any
    tools {
        maven 'Maven'   // use the name you configured in Global Tool
        jdk 'JDK17'
    }
    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/<your-repo>.git', branch: 'main'
            }
        }
        stage('Build with Maven') {
            steps {
                sh 'mvn clean install'
            }
        }
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh 'mvn sonar:sonar -Dsonar.projectKey=myproject'
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

