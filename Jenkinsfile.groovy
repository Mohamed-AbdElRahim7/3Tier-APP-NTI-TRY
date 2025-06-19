
pipeline {
  agent any

  environment {
    AWS_ACCESS_KEY_ID     = credentials('aws-access-key-id')
    AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
    ECR_REPO              = "757351641388.dkr.ecr.us-east-1.amazonaws.com"
    REGION                = "us-east-1"
    SONARQUBE             = "SonarQubeServer"
  }

  tools {
    maven 'Maven 3.8.6'
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('SonarQube Scan') {
      environment {
        SONAR_TOKEN = credentials('sonarqube-token')
      }
      steps {
        withSonarQubeEnv('SonarQube') {
          sh 'sonar-scanner -Dsonar.projectKey=my-project -Dsonar.sources=. -Dsonar.host.url=$SONAR_HOST_URL -Dsonar.login=$SONAR_TOKEN'
        }
      }
    }

    stage('Wait for Quality Gate') {
      steps {
        timeout(time: 5, unit: 'MINUTES') {
          waitForQualityGate abortPipeline: true
        }
      }
    }

    stage('Docker Build') {
      steps {
        dir('dockerfiles/backend') {
          sh 'docker build -t $ECR_REPO/nti-3tier-app-backend:$BUILD_NUMBER .'
        }
        dir('dockerfiles/frontend') {
          sh 'docker build -t $ECR_REPO/nti-3tier-app-frontend:$BUILD_NUMBER .'
        }
      }
    }

    stage('Trivy Scan Docker Images') {
      steps {
        sh 'trivy image $ECR_REPO/nti-3tier-app-backend:$BUILD_NUMBER || echo "⚠️ Trivy scan reported vulnerabilities (backend)."'
        sh 'trivy image $ECR_REPO/nti-3tier-app-frontend:$BUILD_NUMBER || echo "⚠️ Trivy scan reported vulnerabilities (frontend)."'
      }
    }

    stage('Login to ECR') {
      steps {
        sh 'aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $ECR_REPO'
      }
    }

    stage('Push to ECR') {
      steps {
        sh 'docker push $ECR_REPO/nti-3tier-app-backend:$BUILD_NUMBER'
        sh 'docker push $ECR_REPO/nti-3tier-app-frontend:$BUILD_NUMBER'
      }
    }

    stage('Configure kubectl') {
      steps {
        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-creds']]) {
          sh '''
            aws eks update-kubeconfig --region us-east-1 --name nti-3Tier-App
          '''
        }
      }
    }

    stage('Deploy to EKS via Helm') {
      steps {
        sh '''
          helm upgrade --install backend ./helm/backend             --set image.repository=$ECR_REPO/nti-3tier-app-backend             --set image.tag=$BUILD_NUMBER             --namespace default --create-namespace --wait

          helm upgrade --install frontend ./helm/frontend             --set image.repository=$ECR_REPO/nti-3tier-app-frontend             --set image.tag=$BUILD_NUMBER             --namespace default --create-namespace --wait
        '''
      }
    }

    stage('Install Monitoring Stack') {
      steps {
        sh '''
          helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
          helm repo update
          helm upgrade --install monitoring prometheus-community/kube-prometheus-stack             -f helm-monitoring/grafana-values.yaml             --namespace monitoring --create-namespace
        '''
      }
    }
  }

  post {
    success {
      echo '✅ Deployment pipeline completed successfully!'
    }
    failure {
      echo '❌ Deployment pipeline failed. Check logs for more details.'
    }
  }
}
