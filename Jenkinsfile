pipeline {
    agent any

    stages {
        stage('Build + test') {
        // simply run maven and watch for errors, any pr
            when {
                branch 'PR-*'
            }
            steps {
               configFileProvider(
                [configFile(fileId: 'global-maven-settings', variable: 'MAVEN_SETTINGS')]) {
                sh 'mvn -s $MAVEN_SETTINGS clean package'
                }
            }
        }
        stage('Build + upload') {
        // real build, if happy then upload artifact + make docker, dev branch
            when {
                branch 'main'
            }
            steps {
               configFileProvider(
                [configFile(fileId: 'global-maven-settings', variable: 'MAVEN_SETTINGS')]) {
                sh 'mvn -s $MAVEN_SETTINGS clean package'
                }
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
