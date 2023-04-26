pipeline {
  agent {
    node {
      label 'build-image'
    }

  }
  stages {
    stage('Checkout') {
      steps {
        sh 'git clone https://github.com/phuongbc20/flutter-example.git -b main'
      }
    }

    stage('Build image') {
      steps {
        sh 'docker build -f flutter-example/Dockerfile -t phuongbc20/flutter-apk:${BUILD_NUMBER} -t phuongbc20/flutter-apk:latest .'
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

    stage('Clear workspace') {
      steps {
        cleanWs(cleanWhenSuccess: true, cleanWhenFailure: true, cleanWhenAborted: true, cleanWhenNotBuilt: true, cleanWhenUnstable: true, cleanupMatrixParent: true, deleteDirs: true, disableDeferredWipeout: true)
      }
    }

  }
  environment {
    DOCKERHUB_PASSWORD = 'credentials(\'dockerhub\')'
  }
}