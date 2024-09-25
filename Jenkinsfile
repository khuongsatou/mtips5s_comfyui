pipeline {
    agent any
    options {
        // This is required if you want to clean before build
        skipDefaultCheckout(true)
    }
    stages {
        stage('Clear') {
            steps {
                // Clean before build
                cleanWs()
                // We need to explicitly checkout from SCM here
                checkout scm
                echo "Clear ${env.JOB_NAME}..."
            }
        }
        stage('Clone') {
            steps {
                git branch: 'dev_3', url: 'https://[https://github.com/settings/tokens]@github.com/khuongsatou/toolmtipscoder.git'
                echo 'Done step clone'
            }
        }
        stage('Test Docker Setup') {
            steps {
                sh 'docker --version' // Kiểm tra Docker CLI
            }
        }
        stage('Build python') {
            agent {
                docker {
                    image 'python:3.9'
                    // Run the container on the node specified at the
                    // top-level of the Pipeline, in the same workspace,
                    // rather than on a new node entirely:
                    reuseNode true
                }
            }
            steps {
                sh 'python3 --version'
                sh 'python3 -m venv env'
                sh '. env/bin/activate'
                sh 'pip install -r requirements.txt'
                sh '''
                    pytest --maxfail=5 --disable-warnings
                '''     
            }
        }
        // stage('Test') {
        //     steps {
        //         echo 'Running tests...'
        //         sh '''
        //             pytest --maxfail=5 --disable-warnings
        //         '''      
        //         echo 'Done step Test'
        //     }
        // }
        stage('Build Docker and Push') {
            steps {
                withDockerRegistry(credentialsId: 'mtips5s_docker', url: 'https://index.docker.io/v1/') {
                    // some block um
                    sh 'docker system prune -f'
                    sh 'docker build --platform linux/amd64 -t khuong123/mtips5s_web:dev_11 .'
                    sh 'docker push khuong123/mtips5s_web:dev_11'
                    echo 'Done step Build'
                }
            }
        } 
        stage('SSH Remote to project') {
            steps {
                script {
                    def deploying = "#!/bin/bash\n"+
                    "cd /home/mtips5s\n"+
                    "docker pull khuong123/mtips5s_web:dev_11\n"+
                    "docker compose up --remove-orphans --build -d\n"+
                    "docker system prune -f\n"
                    

                    sshagent(credentials: ['mtips5s_ssh_2'], ignoreMissing: true) {
                        // some block
                        echo 'Chuẩn bị xác thực'
                        sh """
                            ssh -o StrictHostKeyChecking=no -l root 45.77.242.223 "echo \\\"${deploying}\\\" > deploy.sh && chmod +x deploy.sh && ./deploy.sh"
                        """
                         echo 'Done step Pull and deloy'
                    }
                }
               
            }
        }
    }
    post {
        // Clean after build
        always {
            cleanWs(cleanWhenNotBuilt: false,
                    deleteDirs: true,
                    disableDeferredWipeout: true,
                    notFailBuild: true,
                    patterns: [[pattern: '.gitignore', type: 'INCLUDE'],
                               [pattern: '.propsfile', type: 'EXCLUDE']])
            
            echo 'Cleaning up Docker images...'
            sh 'docker system prune -f' // Xóa tất cả các images Docker
            echo 'Docker images cleanup completed'
        }
    }
}