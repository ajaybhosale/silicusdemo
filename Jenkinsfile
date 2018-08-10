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
        sh '''sonar.projectKey=silicus-php-demo:master
sonar.host.url=http://silicus.eastus.cloudapp.azure.com:9000
sonar.sourceEncoding=UTF-8
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