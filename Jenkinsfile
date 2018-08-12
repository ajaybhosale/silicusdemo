pipeline {
  agent any
  stages {
    stage('Static Code Analysis') {
      parallel {
        stage('PHP CPD') {
          steps {
            sh 'echo \'Starting PHP copy paste\''
          }
        }
        stage('Calculating LOC') {
          steps {
            sh 'echo \'Calculating LOC\''
          }
        }
        stage('PHP Code Sniffer') {
          steps {
            sh 'echo \'Code sniffer test\''
          }
        }
        stage('PHP Depend') {
          steps {
            sh 'echo \'PHP Depend\''
          }
        }
        stage('PHP MD') {
          steps {
            sh 'echo \'PHP MD test\''
          }
        }
      }
    }
    stage('Unit Test Cases...') {
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
        mail(subject: 'SilicusDemo Approval ', body: "Hi, Please take a action on new build  <a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>", to: 'ajay.bhosale@silicus.com', replyTo: 'testmili@gmail.com', mimeType: 'text/html', from: 'testmili@gmail.com')
        azureWebAppPublish(azureCredentialsId: 'e0cf6c73-37f0-43dc-924b-0cdb83324f38', appName: 'silicusphpdemo', resourceGroup: 'silicusResourceGroup', publishType: 'docker', dockerFilePath: '**/Dockerfile', deployOnlyIfSuccessful: true, dockerImageTag: '$BUILD_NUMBER', dockerImageName: 'silicusphpdemo')
      }
    }
    stage('Deploy to Staging') {
      steps {
        input(message: 'Deploy to Staging?', id: 'deploy-to-staging', ok: 'Proceed', submitter: 'ajay', submitterParameter: 'yes')
        echo 'Deploy to Staging'
      }
    }
    stage('Deploy to UAT') {
      steps {
        echo 'Deploy to UAT'
        input(id: 'deploy-to-uat', message: 'Deploy to UAT', ok: 'Proceed')
      }
    }
    stage('Deploy to Production') {
      steps {
        echo 'Deploy to Production'
        input(message: 'Deploy to Production', ok: 'Proceed', id: 'deploy-to-production')
      }
    }
    stage('Delete Workspace') {
      steps {
        cleanWs(cleanWhenAborted: true, cleanWhenFailure: true, cleanWhenNotBuilt: true, cleanWhenUnstable: true, cleanWhenSuccess: true, cleanupMatrixParent: true, deleteDirs: true)
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