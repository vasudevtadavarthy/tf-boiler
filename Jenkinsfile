pipeline {
  agent any
  parameters {
    password (name: 'AWS_ACCESS_KEY_ID')
    password (name: 'AWS_SECRET_ACCESS_KEY')
    password (name: 'AWS_SESSION_TOKEN')
  }
  environment {
    TF_WORKSPACE = 'dev' //Sets the Terraform Workspace
    TF_IN_AUTOMATION = 'true'
    AWS_ACCESS_KEY_ID = "${params.AWS_ACCESS_KEY_ID}"
    AWS_SECRET_ACCESS_KEY = "${params.AWS_SECRET_ACCESS_KEY}"
    AWS_SESSION_TOKEN = "${params.AWS_SESSION_TOKEN}"
  }
  stages {

        stage('Init') {
            steps {
                script {
                    def changesExist = -1
                    def target = "${params.target}"
                    env.targetString = ""
                    if (target != '') {
                        target.split(",").each { moduleName ->
                            env.targetString += "-target ${moduleName} "
                        }
                    }
                }
                withAWS(credentials: 'aws-credentials', region: 'eu-west-2') {
                    sh '/var/jenkins_home/terraform version'
                }
            }
        }

     stage('git checkout test') {
        steps {
          sh "ls -la && pwd && /var/jenkins_home/terraform version"
          sh 'printenv'

        }

      }

    stage('Terraform Init') {
      steps {
      withAWS(credentials: 'aws-credentials', region: 'eu-west-2') {
            dir ('infra'){
                sh "/var/jenkins_home/terraform init -backend-config=bucket=vasudev-terraform-dev -backend-config=key=terraform.tfstate -backend-config=region=eu-west-2 -backend-config=profile=nexmo-dev -input=false"
            }
        }
      }
    }
//     stage('Terraform Plan') {
//       steps {
//         sh "cd infra && /var/jenkins_home/terraform plan -var-file='../env/region/eu-west-2/dev.tf' -var=aws_region=eu-west-2 -out=tfplan -input=false"
//       }
//     }
//     stage('Terraform Apply') {
//       steps {
//         input 'Apply Plan'
//         sh "cd infra && /var/jenkins_home/terraform apply -input=false tfplan"
//       }
//     }
  }
}