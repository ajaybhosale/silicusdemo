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
        sh 'echo \'Sonarqube Analysis\''
      }
    }
    stage('Build Docker Image') {
      steps {
        echo 'Docker Image'
      }
    }
  }
}