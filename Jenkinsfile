pipeline {
  agent any
  stages {
    stage('Static Code Analysis') {
      steps {
        sh 'echo \'Hello\''
      }
    }
    stage('Unit Test Cases') {
      steps {
        sh 'echo \'Unit test Cases\''
      }
    }
    stage('SonarQube Analysis') {
      steps {
        sh '''sonar.projectName=Silicus-PHP-Demo
sonar.projectKey=silicus-php-demo:master
sonar.branch=-${GIT_BRANCH}
sonar.host.url=http://silicus.eastus.cloudapp.azure.com:9000
sonar.sourceEncoding=UTF-8
sonar.sources=/var/lib/jenkins/workspace/${JOB_NAME}/
sonar.language=php
sonar.projectVersion=${BUILD_NUMBER}'''
      }
    }
    stage('Build Docker Image') {
      steps {
        echo 'Docker Image'
      }
    }
  }
}