pipeline {

    agent {
        label 'roboshop'
    }

    options {
        timestamps()
    }

    stages {

        stage('Checkout') {
            steps {
                echo 'Checking out Terraform code...'
            }
        }

        stage('Terraform Init') {
            steps {
                dir('terraform') {
                    sh 'terraform init -reconfigure'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir('terraform') {
                    sh 'terraform plan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('terraform') {
                    sh 'terraform apply -auto-approve'
                }
            }
        }
    }

    post {
        success {
            echo 'Terraform deployment completed successfully!'
        }

        failure {
            echo 'Terraform deployment failed!'
        }
    }
}