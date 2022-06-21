def imageName = 'mlabouardy/movies-loader'


def registry = '635154829813.dkr.ecr.us-west-2.amazonaws.com/mlabouardy/movies-loader'

node('workers'){
    stage('Checkout'){
        checkout scm
    }

    stage('Unit Tests'){
        def imageTest= docker.build("${imageName}-test", "-f Dockerfile.test .")
        sh "docker run --rm -v $PWD/reports:/app/reports ${imageName}-test"
        
    }

    stage('Build'){
        docker.build(imageName)
    }

    stage('Push'){
         
           
 sh "aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin 635154829813.dkr.ecr.us-west-2.amazonaws.com/mlabouardy/movies-loader"
 sh "docker tag mlabouardy/movies-loader:latest 635154829813.dkr.ecr.us-west-2.amazonaws.com/mlabouardy/movies-loader:latest"
 sh "docker push 635154829813.dkr.ecr.us-west-2.amazonaws.com/mlabouardy/movies-loader:latest"
            
          
    }
}

def commitID() {
    sh 'git rev-parse HEAD > .git/commitID'
    def commitID = readFile('.git/commitID').trim()
    sh 'rm .git/commitID'
    commitID
}
