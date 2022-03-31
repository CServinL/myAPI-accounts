node {
    def app
    stage('Clone') {
        checkout scm 
    }
    stage('Build') {
        app = docker.build("myapi-accounts:test")
    }
    stage('TestBuild') {
        app.inside {
            sh 'set'
            sh 'pwd'
            sh 'pip list'
            sh 'cd src; python init-db.py;'
            sh 'cd tests; python tests.py'
        }
    }
    stage('Deploy') {
        sh 'docker stop myapi-accounts || true && docker rm myapi-accounts || true'
        sh 'docker run -p 5000:5000 -d --rm --name myapi-accounts -e MYSQL_IP="$MYSQL_IP" -e MYSQL_PORT="3306" -e MYSQL_USER="$MYSQL_USER" -e MYSQL_PASSWORD="$MYSQL_PASSWORD" myapi-accounts:latest'
        sh 'docker exec myapi-accounts python init-db.py'
    }
}