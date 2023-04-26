pipeline {
  agent {
    docker {
      image 'phuongbc20/build-flutter-apk:v3'
    }

  }
  stages {
    stage('Check code') {
      parallel {
        stage('Check code') {
          steps {
            sh 'flutter build apk'
          }
        }

        stage('List file') {
          steps {
            sh '''ls
whoami'''
          }
        }

      }
    }

  }
}
