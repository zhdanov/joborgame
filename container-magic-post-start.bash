#!/bin/bash

if nc -z -w2 gitlab-$ENVIRONMENT.gitlab-$ENVIRONMENT 80 2>/dev/null
then

    printf "Host gitlab-$ENVIRONMENT.gitlab-$ENVIRONMENT\n\tStrictHostKeyChecking no\n\tUserKnownHostsFile=/dev/null\n" >> /etc/ssh/ssh_config

    if [[ ! -d /var/www/joborgame-backend ]]; then
        git clone git@gitlab-$ENVIRONMENT.gitlab-$ENVIRONMENT:$HOME_USER_NAME/joborgame-backend.git /var/www/joborgame-backend
        pushd /var/www/joborgame-backend/daemons/magic/
            npm i
        popd
    fi

    node /var/www/joborgame-backend/daemons/magic/magic.js

fi
