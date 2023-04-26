pipeline {
  agent any
  stages {
    stage('Checkout') {
      steps {
        sh 'git clone https://github.com/phuongbc20/flutter-example.git -b main'
      }
    }

    stage('Build image') {
      steps {
        sh 'docker build -t phuongbc20/flutter-apk:${BUILD_NUMBER} -t phuongbc20/flutter-apk:latest .'
      }
    }

    stage('Login') {
      steps {
        sh 'echo $DOCKERHUB_PASSWORD | docker login -u phuongbc20 --password-stdin'
      }
    }

    stage('Push image') {
      steps {
        sh '''docker push phuongbc20/flutter-apk:${BUILD_NUMBER} 
docker push phuongbc20/flutter-apk:latest'''
      }
    }

  }
}