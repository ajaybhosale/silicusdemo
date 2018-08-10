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
        sh '/opt/sonar/bin/sonar-runner -Dsonar.projectName=Silicus-PHP-Demo -Dsonar.projectKey=silicus-php-demo:master -Dsonar.branch=master -Dsonar.host.url=http://silicus.eastus.cloudapp.azure.com:9000 -Dsonar.sourceEncoding=UTF-8 -Dsonar.sources=$WORKSPACE -Dsonar.language=php -Dsonar.projectVersion=1'
      }
    }
    stage('Build Docker Image') {
      steps {
        echo 'Docker Image'
      }
    }
  }
}