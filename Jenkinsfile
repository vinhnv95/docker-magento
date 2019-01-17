pipeline {
    agent {
        docker {
            image 'magestore/compose'
            args '-u root:root -v /var/run/docker.sock:/var/run/docker.sock -v $JENKINS_DATA:$JENKINS_DATA -e JENKINS_DATA=$JENKINS_DATA'
        }
    }
    environment {
        CI = 'true'
    }
    stages {
        stage('Build') {
            steps {
                withCredentials([usernamePassword(credentialsId: env.GITHUB_USER, usernameVariable: 'GITHUB_USERNAME', passwordVariable: 'GITHUB_PASSWORD')])
                {
                    sh './bin/build.sh'
                }
            }
        }
    }
    post {
        always {
            sh './bin/finish.sh'
        }
    }
}
