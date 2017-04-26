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
                archiveArtifacts artifacts: '*.rpm'
            }
        }
    }
}
