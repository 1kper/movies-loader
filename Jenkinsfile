def imageName = 'mlabouardy/movies-loader'
def registry = '635154829813.dkr.ecr.us-east-1.amazonaws.com/mlabouardy/movies-loader'

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
        docker.withRegistry(registry, 'registry') {
           
 sh "aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 635154829813.dkr.ecr.us-east-1.amazonaws.com/${imageName}"
 docker.image(imageName).push(commitID())

            if (env.BRANCH_NAME == 'develop') {
                docker.image(imageName).push('develop')
            }
        }
    }
}

def commitID() {
    sh 'git rev-parse HEAD > .git/commitID'
    def commitID = readFile('.git/commitID').trim()
    sh 'rm .git/commitID'
    commitID
}
