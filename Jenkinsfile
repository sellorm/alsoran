pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh './build docker all'
            }
        }
        stage('Archive') {
            steps {
                archiveArtifacts artifacts: '*.rpm', fingerprint: true
                archiveArtifacts artifacts: '*.deb', fingerprint: true
            }
        }
    }
}
