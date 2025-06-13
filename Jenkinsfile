pipeline {
  agent any

  environment {
    TF_IN_AUTOMATION = "true"
  }

  stages {
    stage('Clone Repo') {
      steps {
        git branch: 'main', url: 'https://github.com/Mohamed-AbdElRahim7/3Tier-App-Nti.git'
        echo '✅ Finished cloning repository.'
      }
    }

    stage('Terraform Init') {
      steps {
        dir('terraform') {
          withCredentials([
            usernamePassword(credentialsId: 'aws-access-key-id', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_ACCESS_KEY_PLACEHOLDER'),
            usernamePassword(credentialsId: 'aws-secret-access-key', usernameVariable: 'AWS_SECRET_ACCESS_KEY', passwordVariable: 'AWS_SECRET_PLACEHOLDER')
          ]) {
            sh '''
              export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
              export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
              terraform init
            '''
            echo '✅ Finished terraform init.'
          }
        }
      }
    }

    stage('Terraform Validate') {
      steps {
        dir('terraform') {
          sh 'terraform validate'
          echo '✅ Finished terraform validate.'
        }
      }
    }

    stage('Terraform Plan') {
      steps {
        dir('terraform') {
          sh 'terraform plan'
          echo '✅ Finished terraform plan.'
        }
      }
    }

    stage('Terraform Apply') {
      steps {
        dir('terraform') {
          input message: "Apply Terraform changes?"
          sh 'terraform apply -auto-approve'
          echo '✅ Finished terraform apply.'
        }
      }
    }
  }
}