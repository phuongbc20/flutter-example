pipeline {
  agent {
    node {
      label 'flutter-apk'
    }

  }

  stages {
    stage('Clear workspace') {
      steps {
        cleanWs(cleanWhenSuccess: true, cleanWhenFailure: true, cleanWhenAborted: true, cleanWhenNotBuilt: true, cleanWhenUnstable: true, cleanupMatrixParent: true, deleteDirs: true, disableDeferredWipeout: true)
      }
    }

    stage('Checkout') {
      steps {
        sh 'git clone https://github.com/phuongbc20/flutter-example.git -b main .'
      }
    }

    stage('Build') {
      steps {
        sh 'flutter build apk'
      }
    }

  }
}