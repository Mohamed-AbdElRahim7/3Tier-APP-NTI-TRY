pipeline {
  agent any

  environment {
    TF_IN_AUTOMATION = "true"
  }

  stages {
    stage('Clone Repo') {
      steps {
        git branch: 'main', url: 'https://github.com/Mohamed-AbdElRahim7/3Tier-APP-NTI-TRY.git'
        echo '✅ Finished cloning repository.'
      }
    }

    stage('Terraform Init') {
      steps {
        dir('terraform') {
          sh 'terraform init'
          echo '✅ Finished terraform init.'
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
          withCredentials([
            usernamePassword(
              credentialsId: 'aws-creds',
              usernameVariable: 'AWS_ACCESS_KEY_ID',
              passwordVariable: 'AWS_SECRET_ACCESS_KEY'
            )
          ]) {
            sh '''
              export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
              export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
              terraform plan
            '''
          }
          echo '✅ Finished terraform plan.'
        }
      }
    }

    stage('Terraform Apply') {
      steps {
        dir('terraform') {
          withCredentials([
            usernamePassword(
              credentialsId: 'aws-creds',
              usernameVariable: 'AWS_ACCESS_KEY_ID',
              passwordVariable: 'AWS_SECRET_ACCESS_KEY'
            )
          ]) {
            sh '''
              export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
              export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
              terraform apply -auto-approve
            '''
          }
          echo '✅ Finished terraform apply.'
        }
      }
    }
  }
}
