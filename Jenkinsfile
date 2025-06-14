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

    stage('Clean Terraform State') {
      steps {
        dir('terraform') {
          echo '🧹 Cleaning old Terraform setup (if any)...'
          sh 'rm -rf .terraform terraform.tfstate terraform.tfstate.backup'
        }
      }
    }

    stage('Terraform Init') {
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
              terraform init
              terraform refresh
            '''
          }
          echo '✅ Finished terraform init & refresh.'
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

  post {
    failure {
      dir('terraform') {
        withCredentials([
          usernamePassword(
            credentialsId: 'aws-creds',
            usernameVariable: 'AWS_ACCESS_KEY_ID',
            passwordVariable: 'AWS_SECRET_ACCESS_KEY'
          )
        ]) {
          sh '''
            echo "⚠️ Pipeline failed. Running terraform destroy..."
            export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
            export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
            terraform destroy -auto-approve || true
          '''
        }
      }
    }

    aborted {
      dir('terraform') {
        withCredentials([
          usernamePassword(
            credentialsId: 'aws-creds',
            usernameVariable: 'AWS_ACCESS_KEY_ID',
            passwordVariable: 'AWS_SECRET_ACCESS_KEY'
          )
        ]) {
          sh '''
            echo "🛑 Pipeline aborted. Running terraform destroy..."
            export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
            export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
            terraform destroy -auto-approve || true
          '''
        }
      }
    }
  }
}
