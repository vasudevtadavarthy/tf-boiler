pipeline {
    agent any
    tools {
        terraform 'terraform'
    }
    parameters {
        password(name: 'AWS_ACCESS_KEY_ID')
        password(name: 'AWS_SECRET_ACCESS_KEY')
        password(name: 'AWS_SESSION_TOKEN')
    }
    environment {
        //     TF_WORKSPACE = 'dev' //Sets the Terraform Workspace
        TF_IN_AUTOMATION = 'true'
        AWS_ACCESS_KEY_ID = "${params.AWS_ACCESS_KEY_ID}"
        AWS_SECRET_ACCESS_KEY = "${params.AWS_SECRET_ACCESS_KEY}"
        AWS_SESSION_TOKEN = "${params.AWS_SESSION_TOKEN}"
    }
    stages {
        stage('Terraform commands') {
            steps {
                 sh '''
                    CWD=$(pwd)

                    for REGION in $(cd $CWD/env/region && ls)
                    do
                      for ENV in $(cd $CWD/env/region/$REGION && ls)
                      do
                    #      //aws switch context
                          echo "switch AWS account for every $ENV && region $REGION"
                          cd $CWD/infra
                          terraform init -reconfigure -backend-config=bucket=vasudev-terraform-dev -backend-config=key=$REGION-$ENV-terraform.tfstate -backend-config=region='eu-west-2' -input=false
                          terraform plan -var-file=../env/region/$REGION/$ENV -var=aws_region=$REGION -out=tfplan -input=false
                    #      terraform apply -input=false tfplan
                          rm -r .terraform/ tfplan
                      done
                    done
                 '''
            }
        }
    }
}