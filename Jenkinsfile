def IMAGE = "userID/docs"
def REPO = "docs"
def BRANCH_NAME = BRANCH_NAME.toLowerCase()

pipeline {
    agent {
        label {
            label ""
            customWorkspace "/var/lib/jenkins/workspace/${REPO}-${BRANCH_NAME}"
        }
    }
      environment{
       pass = credentials('registry-pass')
   }

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
		sh """
		 ./jenkins/build/build.sh
		    """
            }
        }
        stage('Push') {
            steps {
              script {
                  GIT_SHA = sh(
                      returnStdout: true,
                      script: "git log -n 1 --pretty=format:'%h'"
                  )
                  if (env.BRANCH_NAME == 'staging') {
                     sh  "docker login -u loginusername -p $pass"
                     /* sh  "docker tag ${IMAGE}:${BUILD_NUMBER} loginusername/${IMAGE}:${BRANCH_NAME}-${BUILD_NUMBER}" */
                     sh "docker tag ${IMAGE}:latest ${IMAGE}:${BRANCH_NAME}-${GIT_SHA}"
                     sh  "docker push ${IMAGE}:${BRANCH_NAME}-${GIT_SHA}"
                  } else if (env.BRANCH_NAME == 'staging-new'){
                     sh  "docker login -u loginusername -p $pass"
                     /* sh  "docker tag ${IMAGE}:${BUILD_NUMBER} loginusername/${IMAGE}:${BRANCH_NAME}-${BUILD_NUMBER}" */
                     sh "docker tag ${IMAGE}:latest ${IMAGE}:${BRANCH_NAME}-${GIT_SHA}"
                     sh  "docker push ${IMAGE}:${BRANCH_NAME}-${GIT_SHA}"
                      }
                  }
              }

            }
        }

    }
