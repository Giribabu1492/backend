pipeline {
    agent { label 'AGENT-1' }

    environment {
        PROJECT = "EXPENSE"
        COMPONENT = "BACKEND"
        ACC_Id = "805160322688"
        APP_VERSION = ""

    }

    stages {
        stage('Read Version') {
            steps {
                script {
                    def packagejson = readJSON file: 'package.json'
                    env.APP_VERSION = packagejson.version ?: "latest"
                    echo "version is ${env.APP_VERSION}"
                }
            }
        }

        stage('Install dependencies') {
            steps {
                sh 'npm install'
            }
        }

        stage('Docker Build') {
            steps {
                withAWS(region: 'us-east-1', credentials: 'aws-creds') {
                    sh """
                        aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ${ACC_Id}.dkr.ecr.us-east-1.amazonaws.com

                        docker build -t ${ACC_Id}.dkr.ecr.us-east-1.amazonaws.com/${PROJECT}/${COMPONENT}:${env.APP_VERSION} .

                        docker push ${ACC_Id}.dkr.ecr.us-east-1.amazonaws.com/${PROJECT}/${COMPONENT}:${env.APP_VERSION}
                    """
                }
            }
        }
    }

    post {
        always {
            echo "This will always run"
        }
        success {
            echo "Pipeline completed successfully!"
        }
        failure {
            echo "Pipeline failed!"
        }
    }
}