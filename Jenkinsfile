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
        // Inject Nexus credentials from Jenkins
        withCredentials([usernamePassword(credentialsId: 'nexus', usernameVariable: 'NEXUS_USER', passwordVariable: 'NEXUS_PASS')]) {
            
            // Create a temporary settings.xml dynamically
            writeFile file: 'temp-settings.xml', text: """
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0
                              https://maven.apache.org/xsd/settings-1.0.0.xsd">
  <servers>
    <server>
      <id>nexus</id>
      <username>admin</username>
      <password>1234</password>
    </server>
  </servers>
</settings>
"""
            // Deploy artifacts using the temporary settings.xml
            sh 'mvn deploy -s temp-settings.xml'
        }
    }
}

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t varshikka/dicet_tv:latest .'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: "docker", usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh '''
                        echo $PASS | docker login -u $USER --password-stdin
                        docker push varshikka/dicet_tv:latest
                    '''
                }
            }
        }
    }
}



     
 
