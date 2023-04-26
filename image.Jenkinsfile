pipeline {
  agent {
    node {
      label 'build-image'
    }

  }
  parameters {
    string(name: 'FLUTTER_VERSION', defaultValue: '3.7.12', description: 'Flutter version')
    string(name: 'COMMANDLINETOOLS_VERSION', defaultValue: '9477386', description: 'Commandlinetools version number')
    string(name: 'PLATFORMS_VERSION', defaultValue: '33', description: 'Android platforms version')
    string(name: 'BUILD_TOOLS_VERSION', defaultValue: '30.0.3', description: 'Android build tools version ')
    string(name: 'CMDLINE_TOOLS_VERSION', defaultValue: '9.0', description: 'Cmdline tools version')
  }

  stages {
    stage('Clear workspace') {
      steps {
        cleanWs(cleanWhenSuccess: true, cleanWhenFailure: true, cleanWhenAborted: true, cleanWhenNotBuilt: true, cleanWhenUnstable: true, cleanupMatrixParent: true, deleteDirs: true, disableDeferredWipeout: true)
      }
    }

    stage('Checkout') {
      steps {
        sh 'git clone https://github.com/phuongbc20/flutter-example.git -b main'
      }
    }

    stage('Build image') {
      steps {
        sh 'docker build -f flutter-example/Dockerfile -t phuongbc20/flutter-apk:${BUILD_NUMBER} -t phuongbc20/flutter-apk:latest --build-arg FLUTTER_VERSION=${FLUTTER_VERSION} --build-arg COMMANDLINETOOLS_VERSION=${COMMANDLINETOOLS_VERSION} --build-arg PLATFORMS_VERSION=${PLATFORMS_VERSION} --build-arg BUILD_TOOLS_VERSION=${BUILD_TOOLS_VERSION} --build-arg CMDLINE_TOOLS_VERSION=${CMDLINE_TOOLS_VERSION} .'
      }
    }

    stage('Login') {
      steps {
          withCredentials([string(credentialsId: 'dockerhub', variable: 'DOCKERHUB_PASSWORD')]) {
            sh 'echo ${DOCKERHUB_PASSWORD} | docker login -u phuongbc20 --password-stdin'
          }
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