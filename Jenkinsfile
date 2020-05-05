pipeline {
    agent {
        label 's390x'
    }
    environment {
        user_creds = credentials('dockerhub') // dockerhub is user/pass credential stored as Jenkins cred. Token can be used too
        image = 'eltondesouza/go-hello-world:s390x-latest' // Replace with your [dockerid]/go-hello-world:s390x-latest
        registry = 'https://github.com/e-desouza/go-hello-world.git' // Replace with your fork of the hello-world code
    }
    stages {
        stage('Pull Source') {
            steps {
                  sh 'rm -rf go-hello-world'
                  sh 'git clone $registry'
            }
        }
        stage('Build image') {
            steps {
                dir('go-hello-world'){
                  sh 'sudo -n docker build . -t go-hello-world'
                }
            }
        }
        stage('Tagging image') {
            steps {
                  sh 'sudo -n docker tag go-hello-world $image'
            }
        }
        stage('Pushing image') {
            steps {
                  sh 'docker login -u $user_creds_USR -p $user_creds_PSW'
                  sh 'docker push $image'
            }
        }
        stage('Deploy Image to OpenShift') {
            agent { label 'master' }
            steps {
                  sh 'oc login --token=[replace with token] --server=https://api.atsocpd1.dmz:6443 --insecure-skip-tls-verify'
                  sh 'oc delete is/go-hello-world || true' // Delete existing stream
                  sh 'oc delete deploymentconfigs go-hello-world || true' // & deployment config
                  sh 'oc new-app eltondesouza/go-hello-world' // Push new stream
            }
        }
    }
}
