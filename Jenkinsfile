pipeline {
    agent { label 'AGENT-1' }

    environment {
        PROJECT = "EXPENSE"
        COMPONENT = "BACKEND"
        APP_VERSION = ""
    }

  

    
    stages {
        stage('Read Version') {
            steps {
                script {
                    def packagejson = readJSON file: 'package.json'

                    APP_VERSION = packagejson.version

                    echo "version is ${APP_VERSION}"
               
                }
            }
        }

        stage('Install dependencies ') {
            steps {
                sh 'npm install'
                
            }
    }
   
        


}