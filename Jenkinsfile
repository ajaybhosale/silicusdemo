pipeline {
  agent any
  stages {
    stage('Static Code Analysis') {
      parallel {
        stage('PHP CPD') {
          steps {
            sh 'phpcpd workspace'
          }
        }
        stage('Calculating LOC') {
          steps {
            sh 'phploc workspace'
          }
        }
        stage('PHP Code Sniffer') {
          steps {
            sh 'phpcs --warning-severity=6 --standard=PSR2 --extensions=php'
          }
        }
        stage('PHP Depend') {
          steps {
            sh 'pdepend --ignore=vendor --summary-xml=/tmp/summary.xml --jdepend-chart=/tmp/jdepend.svg --overview-pyramid=/tmp/pyramid.svg workspace'
          }
        }
        stage('PHP MD') {
          steps {
            sh 'phpmd workspace/public/index.php text static_analysis/md_rulesets/cleancode.xml,static_analysis/md_rulesets/naming.xml,static_analysis/md_rulesets/codesize.xml'
          }
        }
        stage('PHP Lint Test') {
          steps {
            sh 'php -l workspace'
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
      environment {
        AZURE_CR_USERNAME = 'silicus'
        AZURE_CR_PASSWORD = '5zNvbJC7tidlPx/erzMysNuPwx5IRREF'
        AZURE_CR_Login = 'silicus.azurecr.io'
        AZURE_CR_IMAGE = 'silicus-php-demo-dit'
      }
      steps {
        sh '''docker login --username silicus --password 5zNvbJC7tidlPx/erzMysNuPwx5IRREF silicus.azurecr.io
docker build -t silicus-php-demo-dit .
docker tag silicus-php-demo-dit silicus.azurecr.io/silicus-php-demo-dit:latest
docker tag silicus-php-demo-dit silicus.azurecr.io/silicus-php-demo-dit:1
docker push silicus.azurecr.io/silicus-php-demo-dit:latest
docker push silicus.azurecr.io/silicus-php-demo-dit:1'''
        mail(subject: 'SilicusDemo Approval ', body: "Hi, Please take a action on new build  <a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>", to: 'ajay.bhosale@silicus.com', replyTo: 'testmili@gmail.com', mimeType: 'text/html', from: 'testmili@gmail.com')
      }
    }
    stage('Deploy to Staging') {
      steps {
        input(message: 'Deploy to Staging?', id: 'deploy-to-staging', ok: 'Proceed', submitter: 'ajay', submitterParameter: 'yes')
        sh '''docker login --username silicus --password 5zNvbJC7tidlPx/erzMysNuPwx5IRREF silicus.azurecr.io
docker build -t silicus-php-demo-sit .
docker tag silicus-php-demo-dit silicus.azurecr.io/silicus-php-demo-sit:latest
docker tag silicus-php-demo-dit silicus.azurecr.io/silicus-php-demo-sit:1
docker push silicus.azurecr.io/silicus-php-demo-sit:latest
docker push silicus.azurecr.io/silicus-php-demo-sit:1'''
      }
    }
    stage('Deploy to UAT') {
      steps {
        input(id: 'deploy-to-uat', message: 'Deploy to UAT', ok: 'Proceed', submitter: 'ajay', submitterParameter: 'yes')
        sh '''docker login --username silicus --password 5zNvbJC7tidlPx/erzMysNuPwx5IRREF silicus.azurecr.io
docker build -t silicus-php-demo-uat .
docker tag silicus-php-demo-dit silicus.azurecr.io/silicus-php-demo-uat:latest
docker tag silicus-php-demo-dit silicus.azurecr.io/silicus-php-demo-uat:1
docker push silicus.azurecr.io/silicus-php-demo-uat:latest
docker push silicus.azurecr.io/silicus-php-demo-uat:1'''
      }
    }
    stage('Deploy to Production') {
      steps {
        input(message: 'Deploy to Production', ok: 'Proceed', id: 'deploy-to-production', submitter: 'ajay', submitterParameter: 'yes')
        sh '''docker login --username silicus --password 5zNvbJC7tidlPx/erzMysNuPwx5IRREF silicus.azurecr.io
docker build -t silicus-php-demo-prod .
docker tag silicus-php-demo-dit silicus.azurecr.io/silicus-php-demo-prod:latest
docker tag silicus-php-demo-dit silicus.azurecr.io/silicus-php-demo-prod:1
docker push silicus.azurecr.io/silicus-php-demo-prod:latest
docker push silicus.azurecr.io/silicus-php-demo-prod:1'''
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