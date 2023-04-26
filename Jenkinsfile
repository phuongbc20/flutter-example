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
        sh 'docker build -t phuongbc20/flutter-apk:'
      }
    }

  }
}