pipeline {
 agent {
  label 'l1cc'
 }
 environment {
    user_creds = credentials('dockerhub') // dockerhub is user/pass credential stored as Jenkins cred. Token can be used too
    image='eltondesouza/go-hello-world:s390x-latest' // Replace with your [dockerid]/go-hello-world:s390x-latest
    registry='https://github.com/e-desouza/go-hello-world.git' // Replace with your fork of the hello-world code
 }
 stages {
  stage('Pull Source') {
   steps {
    sh '''
    rm -rf go-hello-world
    git clone $registry
    '''
   }
  }
  stage('Build image') {
   steps {
    sh '''cd go-hello-world
    sudo -n docker build . -t go-hello-world'''
   }
  }
  stage('Tagging image') {
   steps {
    sh 'sudo -n docker tag go-hello-world $image'
   }
  }
  stage('Pushing image') {
   steps {
    sh '''docker login -u $user_creds_USR -p $user_creds_PSW
   docker push $image'''
   }
  }  
  stage('Deploy Image to OpenShift') {
     agent {
  label 'master'
 }
   steps {
    sh '''
    oc login --token=XXX --server=YYY
    oc delete is/go-hello-world # Delete existing stream
    oc new-app eltondesouza/go-hello-world # Push new stream
    '''
   }
  }
 }
}