node {
    def app
    stage('Clone') {
        checkout scm 
    }
    stage('Build') {
        app = docker.build("myapi-accounts:test")
    }
    stage('PrepEnv') {
        app.inside {
            sh 'set'
            sh 'pwd'
            sh 'pip install requests'
            sh 'pip list'
        }
    }
    stage('DeployTest') {
        sh 'docker stop myapi-accounts-test || true && docker rm myapi-accounts-test || true'
        sh 'docker run -p 5000:5000 -d --rm --name myapi-accounts-test -e MYSQL_IP="$MYSQL_IP" -e MYSQL_PORT="3306" -e MYSQL_USER="$MYSQL_USER" -e MYSQL_PASSWORD="$MYSQL_PASSWORD" myapi-accounts:test'
        sh 'docker exec myapi-accounts python init-db.py'
    }
    stage('TestApp') {
        app.inside {
            sh 'python tests/tests.py'
        }
        sh 'docker stop myapi-accounts-test || true && docker rm myapi-accounts-test || true'
    }
    stage('DeployOk') {
        sh 'docker stop myapi-accounts || true && docker rm myapi-accounts || true'
        sh 'docker run -p 5000:5000 -d --rm --name myapi-accounts -e MYSQL_IP="$MYSQL_IP" -e MYSQL_PORT="3306" -e MYSQL_USER="$MYSQL_USER" -e MYSQL_PASSWORD="$MYSQL_PASSWORD" myapi-accounts:latest'
        sh 'docker exec myapi-accounts python init-db.py'
    }
}