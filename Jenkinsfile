node {
    def app
    stage('Clone') {
        checkout scm 
    }
    stage('Build') {
        app = docker.build("myapi-accounts:test")
    }
    stage('InitDb') {
        app.inside {
            sh 'set'
            sh 'pwd'
            sh 'pip list'
            sh 'cd src; python init-db.py;'
        }
    }
    stage('DeployTest') {
        sh 'docker stop myapi-accounts-test || true && docker rm myapi-accounts-test || true'
        sh 'docker run -p 6000:6000 -d --rm --name myapi-accounts-test -e MYSQL_IP="$MYSQL_IP" -e MYSQL_PORT="3306" -e MYSQL_USER="$MYSQL_USER" -e MYSQL_PASSWORD="$MYSQL_PASSWORD" myapi-accounts:test'
        sh 'python3 tests.py `docker inspect --format "{{ .NetworkSettings.IPAddress }}" myapi-accounts-test`'
    }
    stage('DeployTest') {
        sh 'docker stop myapi-accounts-test || true && docker rm myapi-accounts-test || true'
        sh 'docker run -p 6000:6000 -d --rm --name myapi-accounts-test -e MYSQL_IP="$MYSQL_IP" -e MYSQL_PORT="3306" -e MYSQL_USER="$MYSQL_USER" -e MYSQL_PASSWORD="$MYSQL_PASSWORD" myapi-accounts:test'
        try {
            sh 'python3 tests.py `docker inspect --format "{{ .NetworkSettings.IPAddress }}" myapi-accounts-test`'
        }
        catch (exc) {
            sh 'docker stop myapi-accounts-test || true && docker rm myapi-accounts-test || true'
            throw
        }
    }
    stage('Deploy') {
        sh 'docker stop myapi-accounts || true && docker rm myapi-accounts || true'
        sh 'docker run -p 5000:5000 -d --rm --name myapi-accounts -e MYSQL_IP="$MYSQL_IP" -e MYSQL_PORT="3306" -e MYSQL_USER="$MYSQL_USER" -e MYSQL_PASSWORD="$MYSQL_PASSWORD" myapi-accounts:latest'
        sh 'docker exec myapi-accounts python init-db.py'
    }
}