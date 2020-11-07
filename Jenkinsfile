// Pipeline for Mkdocs documentation web site
// 
pipeline{
  options {
    timestamps()
  } 
  agent {
    dockerfile {
      filename 'Docker/Dockerfile'
      reuseNode true
    }
  } 

  stages{

    stage ('Install pre reqs') {
      steps {
        sh '''
        git config --global credential.helper 'cache'
        '''

        withCredentials ([usernamePassword(credentialsId: 'lgil3-publish-tutorials', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
          sh '''
            git remote set-url origin https://$USERNAME:$PASSWORD@github.dxc.com/lgil3/tutorials
            pip install -r requirements.txt
          '''

        }
      }
    }

    stage ('Build site') {
      steps {
          sh '''
            marp slidedecks/kubernetes-overview/README.md -o docs/Kubernetes/kubernetes-overview/README.html
            cp -r slidedecks/kubernetes-overview/img docs/Kubernetes/kubernetes-overview/

            mkdocs build
          '''
      }
    }

    stage ('publish') {
    //   when {
    //     anyOf {
    //       // We only publish when on master
    //       branch 'master'
    //     }
    //   }
      steps {
        // The 'magic sed' adds PDF export when published through the pipeline (too slow locally)
        withCredentials ([usernamePassword(credentialsId: 'lgil3-publish-tutorials', usernameVariable: 'USERNAME', passwordVariable: 'GH_TOKEN')]) {
          sh '''
            export MKDOCS_GIT_COMMITTERS_APIKEY=$GH_TOKEN
            mkdocs gh-deploy --force
          '''
        }
      }
    }
  }  // end stages
//  post { // Make site an artifact
//      always {
//          archiveArtifacts artifacts: 'site/*', fingerprint: true
//      }
//  }
} // end pipeline