pipeline {
  agent any
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