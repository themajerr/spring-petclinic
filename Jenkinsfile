pipeline {
    agent any
    environment {
        GITHUB = credentials('github-pass') 
    }
    
    stages {
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
                -t europe-west1-docker.pkg.dev/gd-gcp-internship-devops/docker-registry/petclinic:${TAG} .'''
                sh 'docker push europe-west1-docker.pkg.dev/gd-gcp-internship-devops/docker-registry/petclinic:${TAG}'
            }
        }
        
        stage('Main - create tag') {
            when { branch 'main' }
            steps { 
                sh './gradlew release -Prelease.disableChecks -Prelease.pushTagsOnly'
            }
        }

        stage('Main - tag the artifact') {
            when { branch 'main' }
            environment {
                TAG = sh(script: 'echo "$(./gradlew cV -q -Prelease.quiet)-$(git rev-parse --short HEAD)"', returnStdout: true)
            }
            steps { 
                sh '''docker build \
                -t europe-west1-docker.pkg.dev/gd-gcp-internship-devops/docker-registry/petclinic:${TAG} .'''
                sh 'docker push europe-west1-docker.pkg.dev/gd-gcp-internship-devops/docker-registry/petclinic:${TAG}'
            }
        }
    }
}
