pipeline {
    // Docker needed to build & push init containers.
    agent { label 'docker' }

    options {
        timestamps()
        ansiColor('xterm')
    }

    stages {
        stage('Push init containers') {
            steps {
                sh './init-containers/push-containers.sh'
            }
        }
    }

    post {
        cleanup {
            cleanWs()
        }
    }
}
