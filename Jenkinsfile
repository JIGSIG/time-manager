Jenkinsfile (Declarative Pipeline)
pipeline {
    agent any

    stages {
        stage('build') {
            steps {
                echo 'Building application...'
                // sh 'docker-compose build'
                echo 'Build done'
            }
        }
        
        stage('test') {
            steps {
                echo 'Testing application...'
                echo 'Test done'
            }
        }
        
        stage('deploy') {
            steps {
                echo 'Deploying application...'
                // sh 'docker-compose up'
                echo 'Deployment done'
            }
        }
    }
}
