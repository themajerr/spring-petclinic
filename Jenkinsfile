pipeline {
    agent any

    stages {
        stage('PR - Check') {
            when { branch 'PR-*' }
            sh './gradlew check'
        }
        stage('PR - Test') {
            when { branch 'PR-*' }
            sh './gradlew test'
        }
        stage('PR - Build') {
            when { branch 'PR-*' }
            sh './gradlew build'
        }
        stage('PR - Push') {
            when { branch 'PR-*' }
            sh 'echo <PLACEHOLDER>'
        }
        
        stage('Main - create tag') {
            when { branch 'main' }
            sh 'echo <create tag>'
        }
        stage('Main - tag the artifact') {
            when { branch 'main' }
            sh 'echo <tag artifact>'
        }
        stage('Main - push to repo') {
            when { branch 'main' }
            sh 'echo <push>'
        }
    }
}
