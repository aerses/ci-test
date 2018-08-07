pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                // checkout([$class: 'GitSCM', branches: [[name: '*/master']], browser: [$class: 'GithubWeb', repoUrl: 'https://github.com/aerses/ci-test'], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'test_ssh_key', url: 'git@github.com:aerses/ci-test.git']]])
                sh 'ls -al'
            }
        }
        stage('Test') {
            steps {
                echo 'Test'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploy'
            }
        }
    }
}
