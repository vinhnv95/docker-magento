pipeline {
    agent {
        docker {
            image 'magestore/compose'
            args '-u root:root -v /var/run/docker.sock:/var/run/docker.sock -v $JENKINS_DATA:$JENKINS_DATA -e JENKINS_DATA=$JENKINS_DATA'
            label 'docker-magento'
        }
    }
    parameters {
        credentials(name: 'GITHUB_USER', description: 'Github username and password', defaultValue: 'c005e544-9ad8-48be-ba44-a0f6d519a2ec', credentialType: "Username with password", required: true)
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
