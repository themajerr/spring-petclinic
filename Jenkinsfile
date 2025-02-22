pipeline {
    agent any
    environment {
        GITHUB = credentials('github-pass') 
    }
    
    stages {
        stage('GLOBAL - fetch tags') {
            steps {
                sh 'git fetch --tags'
            }
        }
        stage('PR - Check') {
            when { branch 'PR-*' }
            steps {
                sh './gradlew check'
            }
        }

        stage('PR - Test') {
            when { branch 'PR-*' }
            steps {
                sh './gradlew test'
            }
        }

        stage('PR - Build') {
            when { branch 'PR-*' }
            steps {
                sh './gradlew build'
            }
        }

        stage('PR - Build + Push') {
            when { branch 'PR-*' }
            environment {
                TAG = sh(script: 'echo "$(./gradlew cV -q -Prelease.quiet)-$(git rev-parse --short HEAD)"', returnStdout: true)
            }
            steps { 
                sh '''docker build \
                -t europe-west1-docker.pkg.dev/gd-gcp-internship-devops/docker-registry/petclinic-SNAPSHOT:${TAG} .'''
                sh 'docker push europe-west1-docker.pkg.dev/gd-gcp-internship-devops/docker-registry/petclinic-SNAPSHOT:${TAG}'
            }
        }

        stage('Main - create tag') {
            when { branch 'main' }
            steps { 
                sh './gradlew release -Prelease.disableChecks -Prelease.pushTagsOnly -Prelease.customUsername=$GITHUB_USR -Prelease.customPassword=$GITHUB_PSW'
            }
        }

        stage('Main - build jar') {
            when { branch 'main' }
            steps {
                sh './gradlew build'
            }
        }
        
        stage('Main - tag the artifact and push to repo') {
            when { branch 'main' }
            environment {
                TAG = sh(script: 'echo "$(./gradlew cV -q -Prelease.quiet)"', returnStdout: true)
            }
            steps { 
                sh '''docker build \
                -t europe-west1-docker.pkg.dev/gd-gcp-internship-devops/docker-registry/petclinic:${TAG} \
                -t europe-west1-docker.pkg.dev/gd-gcp-internship-devops/docker-registry/petclinic:latest .'''
                sh 'docker push europe-west1-docker.pkg.dev/gd-gcp-internship-devops/docker-registry/petclinic --all-tags'
            }
        }
    }
}
