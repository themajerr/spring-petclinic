pipeline {
    agent any

    tools {
        maven "maven3"
    }

    stages {
        stage('PreCommit') {
            when { branch 'PR-*' }
            steps {
                configFileProvider(
                    [configFile(fileId: 'global-maven-settings', variable: 'MAVEN_SETTINGS')]) {
                    sh 'mvn -s $MAVEN_SETTINGS -DaltSnapshotDeploymentRepository=nexus_snapshot::http://nexus3-repo:8081/repository/maven_snapshot package'
                }
            }

        }
        stage("Build + push artifact + docker image") {
            when { branch 'springboot3' }
            steps {
                configFileProvider(
                    [configFile(fileId: 'global-maven-settings', variable: 'MAVEN_SETTINGS')]) {
                    sh 'mvn -s $MAVEN_SETTINGS -DaltSnapshotDeploymentRepository=nexus_snapshot::http://nexus3-repo:8081/repository/maven_snapshot deploy'
                }
                script {
                    docker.withRegistry("https://0.0.0.0:2239/repository/docker-snapshot-registry/", "nexus") {
                        def TAG_SELECTOR = readMavenPom().getVersion()
                        def customImage = docker.build("petclinic:${TAG_SELECTOR}")
                        customImage.push()
                    }
                }
            }
        }
    }
}
