pipeline {
  environment {
    registry = "montree/jojoe"
    registryCredential = 'dockerhub'
    dockerImage = ''
  }
  agent any
  stages {
    stage('Building Image') {
      steps{
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }
    stage('Push Image') {
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
            /*dockerImage.push('latest')*/
          }
        }
      }
    }
	  stage('Deployment K8s') {
      steps {
			  sh "sed -i 's/tagversion/${BUILD_NUMBER}/g' 03-webserver-deployment-pattern-autoscale.yaml"
        sh 'kubectl apply -f 03-webserver-deployment-pattern-autoscale.yaml --record'
      }
    }
    stage('Remove Unused docker image') {
      steps{
        sh "docker rmi -f $registry:$BUILD_NUMBER"
      }
    }
  }
}
