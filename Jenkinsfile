pipeline {
    agent any
    tools {
        maven 'maven'
        jdk 'java'
    }

    environment {
        DOCKERHUB_CREDENTIALS = 'dockerhub'
        IMAGE_NAME = 'varshikka/dicet_tv'
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
                    sh 'mvn sonar:sonar -Dsonar.projectKey=dicet_tv'
                }
            }
        }

        stage('Quality Gate') {
            steps {
                timeout(time: 5, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }

        stage('Deploy to Nexus (Snapshots)') {
            steps {
                sh 'mvn deploy -s /var/lib/jenkins/.m2/settings.xml'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ${varshikka/dicet_tv}:latest .'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: "${DOCKERHUB_CREDENTIALS}", usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh '''
                        echo $PASS | docker login -u $USER --password-stdin
                        docker push ${varshikka/dicet_tv}:latest
                    '''
                }
            }
        }
    }
}



     

