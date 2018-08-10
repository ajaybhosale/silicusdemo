pipeline {
  agent any
  stages {
    stage('Static Code Analysis') {
      when {
        branch 'development'
      }
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
      environment {
        PROJECT_NAME = 'Silicus-PHP-Demo'
        PROJECT_KEY = 'silicus-php-demo:master'
        PROJECT_BRANCH = 'master'
        SONAR_HOST_URL = 'http://silicus.eastus.cloudapp.azure.com:9000'
        PROJECT_SOURCE_ENCODING = 'UTF-8'
        PROJECT_LANGUAGE = 'php'
      }
      steps {
        sh '''PROJECT_VERSION=1.0.$(date +%y)$(date +%j).$BUILD_NUMBER

/opt/sonar/bin/sonar-runner -Dsonar.projectName=$PROJECT_NAME \\
-Dsonar.projectKey=$PROJECT_KEY \\
-Dsonar.host.url=$SONAR_HOST_URL \\
-Dsonar.sourceEncoding=$PROJECT_SOURCE_ENCODING \\
-Dsonar.sources=$WORKSPACE \\
-Dsonar.language=$PROJECT_LANGUAGE \\
-Dsonar.projectVersion=$PROJECT_VERSION'''
      }
    }
    stage('Deploy to Development') {
      steps {
        echo 'Docker Image'
      }
    }
    stage('Delete Workspace') {
      steps {
        cleanWs(cleanWhenAborted: true, cleanWhenFailure: true, cleanWhenNotBuilt: true, cleanWhenUnstable: true, cleanWhenSuccess: true, cleanupMatrixParent: true, deleteDirs: true)
      }
    }
    stage('Deploy to Staging') {
      steps {
        echo 'Deploy to Staging'
      }
    }
    stage('Deploy to UAT') {
      steps {
        echo 'Deploy to UAT'
      }
    }
    stage('Deploy to Production') {
      steps {
        echo 'Deploy to Production'
      }
    }
  }
  environment {
    Name = 'Ajay'
    Surname = 'Bhosale'
  }
  post {
    success {
      mail(to: 'ajay.bhosale@silicus.com', subject: "Success Pipeline: ${currentBuild.fullDisplayName}", body: "Congratulations pipeline build successfully ${env.BUILD_URL}")

    }

    failure {
      mail(to: 'ajay.bhosale@silicus.com', subject: "Failed Pipeline: ${currentBuild.fullDisplayName}", body: "Something is wrong with ${env.BUILD_URL}")

    }

  }
}