pipeline {
    agent any

    stages {
        stage('Build + test') {
        // simply run maven and watch for errors, any pr
            when {
                branch 'PR-*'
            }
            steps {
               mvn package
            }
        }
        stage('Build + upload') {
        // real build, if happy then upload artifact + make docker, dev branch
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
        stage('Promotion') {
        // 
            steps {
                echo 'Promoting...'
            }
        }
    }
}
