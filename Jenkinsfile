pipeline {
    agent any
    parameters {
        choice(
            name: 'ACTION',
            choices: ['apply', 'destroy'],
            description: 'Choose Terraform Action'
        )
    }

    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key')
        // DB_NAME               = credentials('db-name')
        // DB_PASSWORD           = credentials('db-password')
        PATH = "/usr/local/bin:${env.PATH}"
    }

    stages {
        stage('git clone') {
            steps {
                git branch: 'main', url: 'https://github.com/Sivasaiteja2/AWS-2-Tier-Student-Registration-System.git'
            }
        }
        stage('INIT') {
            steps {
                dir('infra') {
                    sh 'terraform init'
                }
            }
        }
        stage('PLAN') {
            steps {
                dir('infra') {
                    sh 'terraform plan'
                }
            }
        }
        stage('VALIDATE') {
            steps {
                dir('infra') {
                    sh 'terraform validate'
                }
            }
        }
        stage('APPLY') {
            steps {
                dir('infra') {
                    sh 'terraform apply --auto-approve'
                }
            }
        }
        stage('Terraform Destroy') {
            when {
                expression { params.ACTION == 'destroy' }
            }
            steps {
                dir('infra') {
                    sh 'terraform destroy -auto-approve'
                }
            }
        }
    }
}
