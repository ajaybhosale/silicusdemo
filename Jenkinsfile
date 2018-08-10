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
        sh 'sonar-scanner -Dsonar.projectName=Silicus-PHP-Demo -Dsonar.projectKey=silicus-php-demo:master -Dsonar.branch=-${GIT_BRANCH} -Dsonar.host.url=http://silicus.eastus.cloudapp.azure.com:9000 -Dsonar.sourceEncoding=UTF-8 -Dsonar.sources=/var/lib/jenkins/workspace/${JOB_NAME}/ -Dsonar.language=php -Dsonar.projectVersion=${BUILD_NUMBER}'
      }
    }
    stage('Build Docker Image') {
      steps {
        echo 'Docker Image'
      }
    }
  }
}