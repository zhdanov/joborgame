#!/bin/bash

if nc -z -w2 gitlab-prod.gitlab-prod 80 2>/dev/null
then

    printf "Host gitlab-prod.gitlab-prod\n\tStrictHostKeyChecking no\n\tUserKnownHostsFile=/dev/null\n" >> /etc/ssh/ssh_config

    if [[ ! -d /var/www/joborgame-backend ]]; then
        git clone git@gitlab-prod.gitlab-prod:$HOME_USER_NAME/joborgame-backend.git /var/www/joborgame-backend
        pushd /var/www/joborgame-backend/daemons/magic/
            npm i
        popd
    fi

    node /var/www/joborgame-backend/daemons/magic/magic.js

fi
