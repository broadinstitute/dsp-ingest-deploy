pipeline {
    // Docker needed to build & push init containers.
    agent { label 'docker' }

    options {
        timestamps()
        ansiColor('xterm')
    }

    stages {
        stage('Build init containers') {
            steps {
                sh './scripts/build-init-containers.sh'
            }
        }
    }

    post {
        cleanup {
            cleanWs()
        }
    }
}
