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
          withCredentials([usernamePassword(
            credentialsId: 'aws-creds',
            usernameVariable: 'AWS_ACCESS_KEY_ID',
            passwordVariable: 'AWS_SECRET_ACCESS_KEY'
          )]) {
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
          withCredentials([usernamePassword(
            credentialsId: 'aws-creds',
            usernameVariable: 'AWS_ACCESS_KEY_ID',
            passwordVariable: 'AWS_SECRET_ACCESS_KEY'
          )]) {
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
          withCredentials([usernamePassword(
            credentialsId: 'aws-creds',
            usernameVariable: 'AWS_ACCESS_KEY_ID',
            passwordVariable: 'AWS_SECRET_ACCESS_KEY'
          )]) {
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

    stage('Update Ansible Inventory') {
      steps {
        sh '''
          cd terraform
          EC2_IP=$(terraform output -raw jenkins_public_ip)
          echo "✅ EC2 Public IP is: $EC2_IP"
          cd ../ansible
          sed -i "s/^ec2-jenkins .*/ec2-jenkins ansible_host=${EC2_IP} ansible_user=ec2-user ansible_ssh_private_key_file=~/.ssh/jenkins/" inventory
          echo "✅ Inventory file updated with EC2 IP."
        '''
      }
    }

    stage('Prepare SSH Key') {
      steps {
        withCredentials([sshUserPrivateKey(
          credentialsId: 'ec2-ssh-key',
          keyFileVariable: 'SSH_KEY'
        )]) {
          sh '''
            mkdir -p ~/.ssh
            cp $SSH_KEY ~/.ssh/jenkins
            chmod 600 ~/.ssh/jenkins
          '''
          echo '✅ SSH Key prepared for Ansible.'
        }
      }
    }

    stage('Run Ansible Playbook') {
      steps {
        dir('ansible') {
          sh '''
            ansible-playbook -i inventory playbooks/setup.yml
          '''
          echo '✅ Ansible Playbook executed.'
        }
      }
    }
  }

  post {
    failure {
      dir('terraform') {
        withCredentials([usernamePassword(
          credentialsId: 'aws-creds',
          usernameVariable: 'AWS_ACCESS_KEY_ID',
          passwordVariable: 'AWS_SECRET_ACCESS_KEY'
        )]) {
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
        withCredentials([usernamePassword(
          credentialsId: 'aws-creds',
          usernameVariable: 'AWS_ACCESS_KEY_ID',
          passwordVariable: 'AWS_SECRET_ACCESS_KEY'
        )]) {
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
