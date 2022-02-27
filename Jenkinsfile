def sources = ["0-way.scad", "1-way.scad", "2-way.scad", "3-way.scad", "4-way.scad", "5-way.scad", "cover.scad", "demo_all.scad", "demo_assembled.scad", "demo_planter.scad", "demo_tray.scad", "demo_xways.scad", "planter.scad", "resevoir.scad", "tray.scad", "tube_with_hole.scad", "x-way.scad"]
def parallelStagesMap = sources.collectEntries {
  ["${it}" : generateStage(it)]
}

def generateStage(job) {
  return {
    stage("stage: ${job}") {
      container('main') {
        echo "This is ${job}." 
        sh """
          basefile=\$(basename "${job}")
          scad_file="\${basefile%.*}.scad"
          stl_file="\${basefile%.*}.stl"
          
          # make \$stl_file
          mkdir build/
          openscad --D $$fn=100 -o build/\$stl_file \$scad_file
        """
      }
    }
  }
}

pipeline {
  agent {
    kubernetes {
      yaml '''
        apiVersion: v1
        kind: Pod
        spec:
          containers:
            - name: main
              image: ubuntu:latest
              command:
                - cat
              tty: true
              securityContext:
                allowPivilegedEscalation: true
                runAsUser: 0
                runAsGroup: 0
        '''
    }
  }
  stages {
    stage('Setup') {
      steps {
        container('main') {
          sh 'apt-get update'
          sh 'apt-get upgrade -y'
          sh 'apt-get install -y openscad'
        }
      }
    }
    stage('Build') {
      steps {
        container('main') {
          script {
            parallel parallelStagesMap
          }
        }
      }
    }
  }
}