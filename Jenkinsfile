pipeline {
    agent { label 'AGENT-1' }

    environment {
        PROJECT = "EXPENSE"
        COMPONENT = "BACKEND"
        ACC_Id = "805160322688"
        APP_VERSION = " "
    }

    stages {
        stage('Read Version') {
            steps {
                script {
                    def packageJson = readJSON file: 'package.json'
                    env.APP_VERSION = packageJson.version   // use env to persist
                    echo "Version is: ${env.APP_VERSION}"
                }
            }
        }   // ✅ closed stage

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

                        docker build -t ${ACC_Id}.dkr.ecr.us-east-1.amazonaws.com/${PROJECT}/${COMPONENT}:${APP_VERSION} .

                        docker push ${ACC_Id}.dkr.ecr.us-east-1.amazonaws.com/${PROJECT}/${COMPONENT}:${APP_VERSION}
                    """
                }
            }
        }
    }
}
