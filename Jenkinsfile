pipeline {
    agent any

    tools {
        maven "maven3"
    }

    stages {
        stage('PreCommit') {
            steps {
                when { branch 'PR-*' }
                
                configFileProvider(
                    [configFile(fileId: 'global-maven-settings', variable: 'MAVEN_SETTINGS')]) {
                    sh 'mvn -s $MAVEN_SETTINGS -DaltSnapshotDeploymentRepository=nexus_snapshot::http://nexus3-repo:8081/repository/maven_snapshot package'
                }
            }

        }
        stage("Build + push artifact + docker image") {
            steps {
                when { branch 'springboot3' }
                configFileProvider(
                    [configFile(fileId: 'global-maven-settings', variable: 'MAVEN_SETTINGS')]) {
                    sh 'mvn -s $MAVEN_SETTINGS -DaltSnapshotDeploymentRepository=nexus_snapshot::http://nexus3-repo:8081/repository/maven_snapshot deploy'
                }
                script {
                    docker.withRegistry("http://0.0.0.0:2139/repository/docker-snapshot-registry/", "nexus") {
                        def TAG_SELECTOR = readMavenPom().getVersion()
                        def customImage = docker.build("petclinic:${TAG_SELECTOR}")
                        customImage.push()
                    }
                }
            }
        }
    }
}
