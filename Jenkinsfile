pipeline {
    agent any

    stages {
        stage('Build + test') {
        // simply run maven and watch for errors, any pr
            when {
                branch 'PR-*'
            }
            steps {
               maven 'package'
            }
        }
        stage('Build + upload') {
        // real build, if happy then upload artifact + make docker, dev branch
            when {
                branch 'springboot3'
            }
            steps {
               maven 'package'
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
