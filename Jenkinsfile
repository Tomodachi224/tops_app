node {
    try {
        stage('Preparation') {
            git branch: 'master', credentialsId: 'Jenkins-Key', url: 'git@bitbucket.org:company/docker-spp.git'
            sh '''
                cd $WORKSPACE/public/web/modules/
                if [ ! -f $WORKSPACE/public/web/modules/custom/README.md ] ; then
                    rm -rf $WORKSPACE/public/web/modules/custom
                    git clone git@bitbucket.org:company/drupal-custom-modules.git custom
                fi

                cd $WORKSPACE/node
                if [ ! -f $WORKSPACE/node/webcomponents/README.md ] ; then
                    rm -rf $WORKSPACE/node/webcomponents
                    git clone git@bitbucket.org:company/webcomponents.git webcomponents
                fi

                cd $WORKSPACE/public/web/modules/custom/
                git pull origin master

                cd $WORKSPACE/node/webcomponents/
                git pull origin master
                yarn install
                git checkout yarn.lock

                cd $WORKSPACE/public/web/themes/custom/tbdtheme/
                yarn install
                git checkout yarn.lock

                cd $WORKSPACE/node/app/
                yarn install
                git checkout yarn.lock

                cd $WORKSPACE/node/rapis/
                n 16
                yarn install
                git checkout yarn.lock
            '''
        }
        stage('Unit test') {
            sh '''
                ls $WORKSPACE
            '''
        }
        stage('Build Theme') {
            sh '''
                cd $WORKSPACE/public/web/themes/custom/tbdtheme/
                yarn build
            '''
        }
        stage('Build APP') {
            sh '''
                cd $WORKSPACE/node/app/
                yarn build
            '''
        }
        stage('Build RAPIS') {
            sh '''
                cd $WORKSPACE/node/rapis/
                yarn build
            '''
        }
        stage('Deploy Frontend') {
            sh '''
                rsync -a --human-readable --stats --no-owner --no-group $WORKSPACE/public/web/themes/custom/tbdtheme/assets/dist/ root@spp.company.com:/opt/server/public/web/themes/custom/tbdtheme/assets/dist/
                rsync -a --human-readable --stats --no-owner --no-group $WORKSPACE/public/web/themes/custom/tbdtheme/assets/dist-vue/ root@spp.company.com:/opt/server/public/web/themes/custom/tbdtheme/assets/dist-vue/
            '''
        }
        stage('Deploy RAPIS') {
            sh '''
                rsync -a --human-readable --stats --no-owner --no-group $WORKSPACE/node/rapis/dist/ root@spp.company.com:/opt/server/node/rapis/dist/
            '''
        }
        stage('Deploy Backend') {
            sh '''
                export TERM=xterm-256color
                ssh root@spp.company.com /opt/server/bin/deploy.sh
            '''
        }
    } catch (e) {
        // If there was an exception thrown, the build failed
        currentBuild.result = "FAILED"
        throw e

    } finally {
        // Success or failure, always send notifications
        notifyBuild(currentBuild.result)
    }

}

def notifyBuild (String buildStatus = '') {
     // build status of null means successful
    buildStatus =  buildStatus ?: 'SUCCESSFUL'

    // Default values
    def colorName = 'RED'
    def colorCode = '#FF0000'
    def subject = "${buildStatus}: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'"
    def summary = "${subject} (${env.BUILD_URL})"
    def details = """<p>STARTED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
    <p>Check console output at &QUOT;<a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>&QUOT;</p>"""

    // Override default values based on build status
    if (buildStatus == 'STARTED') {
        color = 'YELLOW'
        colorCode = '#FFFF00'
    } else if (buildStatus == 'SUCCESSFUL') {
        color = 'GREEN'
        colorCode = '#00FF00'
    } else {
        color = 'RED'
        colorCode = '#FF0000'
    }

    // Send notifications
    // slackSend (color: colorCode, message: summary)

    bitbucketStatusNotify(
        buildState: buildStatus,
        buildDescription: subject
    )
}
