pipeline {
  agent any
  parameters {
    password (name: 'AWS_ACCESS_KEY_ID')
    password (name: 'AWS_SECRET_ACCESS_KEY')
  }
  environment {
    TF_WORKSPACE = 'dev' //Sets the Terraform Workspace
    TF_IN_AUTOMATION = 'true'
    AWS_ACCESS_KEY_ID = "${params.AWS_ACCESS_KEY_ID}"
    AWS_SECRET_ACCESS_KEY = "${params.AWS_SECRET_ACCESS_KEY}"
  }
  stages {

     stage('git checkout test') {
        steps {
          sh "ls -la && pwd"
        }
      }

    stage('Terraform Init') {
      steps {
        sh "${env.TERRAFORM_HOME}/terraform init -backend-config=bucket=vasudev-terraform-dev -backend-config=key=terraform.tfstate -backend-config=region=eu-west-2 -backend-config=profile=nexmo-dev -input=false"
      }
    }
    stage('Terraform Plan') {
      steps {
        sh "${env.TERRAFORM_HOME}/terraform plan -var-file="'../env/region/eu-west-2/dev.tf'" -var=aws_region=eu-west-2 -out=tfplan -input=false"
      }
    }
    stage('Terraform Apply') {
      steps {
        input 'Apply Plan'
        sh "${env.TERRAFORM_HOME}/terraform apply -input=false tfplan"
      }
    }
  }
}